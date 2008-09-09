From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH 13/24] sound/pci: coding style fixes: korg1212
Date: Tue, 9 Sep 2008 05:55:29 +0400
Message-ID: <20080909015529.GP6211@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by alsa0.perex.cz (Postfix) with ESMTP id 7650710380D
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Sep 2008 03:55:36 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 16so1536279fgg.44
	for <alsa-devel@alsa-project.org>; Mon, 08 Sep 2008 18:55:36 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



- <asm/io.h> -> <linux/io.h>
- remove trailing whitespaces
- convert comments

Only compile tested.

Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---

 sound/pci/korg1212/korg1212.c |  492 ++++++++++++++++++++--------------------
 1 files changed, 246 insertions(+), 246 deletions(-)

diff --git a/sound/pci/korg1212/korg1212.c b/sound/pci/korg1212/korg1212.c
index 5f8006b..d4c7dd7 100644
--- a/sound/pci/korg1212/korg1212.c
+++ b/sound/pci/korg1212/korg1212.c
@@ -36,7 +36,7 @@
 #include <sound/pcm_params.h>
 #include <sound/initval.h>
 
-#include <asm/io.h>
+#include <linux/io.h>
 
 // ----------------------------------------------------------------------------
 // Debug Stuff
@@ -54,7 +54,7 @@
 #endif
 
 // ----------------------------------------------------------------------------
-// Record/Play Buffer Allocation Method. If K1212_LARGEALLOC is defined all 
+// Record/Play Buffer Allocation Method. If K1212_LARGEALLOC is defined all
 // buffers are alocated as a large piece inside KorgSharedBuffer.
 // ----------------------------------------------------------------------------
 //#define K1212_LARGEALLOC		1
@@ -63,21 +63,21 @@
 // Valid states of the Korg 1212 I/O card.
 // ----------------------------------------------------------------------------
 enum CardState {
-   K1212_STATE_NONEXISTENT,		// there is no card here
-   K1212_STATE_UNINITIALIZED,		// the card is awaiting DSP download
-   K1212_STATE_DSP_IN_PROCESS,		// the card is currently downloading its DSP code
-   K1212_STATE_DSP_COMPLETE,		// the card has finished the DSP download
-   K1212_STATE_READY,			// the card can be opened by an application.  Any application
-					//    requests prior to this state should fail.  Only an open
-					//    request can be made at this state.
-   K1212_STATE_OPEN,			// an application has opened the card
-   K1212_STATE_SETUP,			// the card has been setup for play
-   K1212_STATE_PLAYING,			// the card is playing
-   K1212_STATE_MONITOR,			// the card is in the monitor mode
-   K1212_STATE_CALIBRATING,		// the card is currently calibrating
-   K1212_STATE_ERRORSTOP,		// the card has stopped itself because of an error and we
-					//    are in the process of cleaning things up.
-   K1212_STATE_MAX_STATE		// state values of this and beyond are invalid
+   K1212_STATE_NONEXISTENT,		/* there is no card here */
+   K1212_STATE_UNINITIALIZED,		/* the card is awaiting DSP download */
+   K1212_STATE_DSP_IN_PROCESS,		/* the card is currently downloading its DSP code */
+   K1212_STATE_DSP_COMPLETE,		/* the card has finished the DSP download */
+   K1212_STATE_READY,			/* the card can be opened by an application.  Any application */
+					/*    requests prior to this state should fail.  Only an open */
+					/*    request can be made at this state. */
+   K1212_STATE_OPEN,			/* an application has opened the card */
+   K1212_STATE_SETUP,			/* the card has been setup for play */
+   K1212_STATE_PLAYING,			/* the card is playing */
+   K1212_STATE_MONITOR,			/* the card is in the monitor mode */
+   K1212_STATE_CALIBRATING,		/* the card is currently calibrating */
+   K1212_STATE_ERRORSTOP,		/* the card has stopped itself because of an error and we */
+					/*    are in the process of cleaning things up. */
+   K1212_STATE_MAX_STATE		/* state values of this and beyond are invalid */
 };
 
 // ----------------------------------------------------------------------------
@@ -85,48 +85,48 @@ enum CardState {
 // host-to-card doorbell to initiate a command.
 // ----------------------------------------------------------------------------
 enum korg1212_dbcnst {
-   K1212_DB_RequestForData        = 0,    // sent by the card to request a buffer fill.
-   K1212_DB_TriggerPlay           = 1,    // starts playback/record on the card.
-   K1212_DB_SelectPlayMode        = 2,    // select monitor, playback setup, or stop.
-   K1212_DB_ConfigureBufferMemory = 3,    // tells card where the host audio buffers are.
-   K1212_DB_RequestAdatTimecode   = 4,    // asks the card for the latest ADAT timecode value.
-   K1212_DB_SetClockSourceRate    = 5,    // sets the clock source and rate for the card.
-   K1212_DB_ConfigureMiscMemory   = 6,    // tells card where other buffers are.
-   K1212_DB_TriggerFromAdat       = 7,    // tells card to trigger from Adat at a specific
-                                          //    timecode value.
-   K1212_DB_DMAERROR              = 0x80, // DMA Error - the PCI bus is congestioned.
-   K1212_DB_CARDSTOPPED           = 0x81, // Card has stopped by user request.
-   K1212_DB_RebootCard            = 0xA0, // instructs the card to reboot.
-   K1212_DB_BootFromDSPPage4      = 0xA4, // instructs the card to boot from the DSP microcode
-                                          //    on page 4 (local page to card).
-   K1212_DB_DSPDownloadDone       = 0xAE, // sent by the card to indicate the download has
-                                          //    completed.
-   K1212_DB_StartDSPDownload      = 0xAF  // tells the card to download its DSP firmware.
+   K1212_DB_RequestForData        = 0,    /* sent by the card to request a buffer fill. */
+   K1212_DB_TriggerPlay           = 1,    /* starts playback/record on the card. */
+   K1212_DB_SelectPlayMode        = 2,    /* select monitor, playback setup, or stop. */
+   K1212_DB_ConfigureBufferMemory = 3,    /* tells card where the host audio buffers are. */
+   K1212_DB_RequestAdatTimecode   = 4,    /* asks the card for the latest ADAT timecode value. */
+   K1212_DB_SetClockSourceRate    = 5,    /* sets the clock source and rate for the card. */
+   K1212_DB_ConfigureMiscMemory   = 6,    /* tells card where other buffers are. */
+   K1212_DB_TriggerFromAdat       = 7,    /* tells card to trigger from Adat at a specific */
+                                          /*    timecode value. */
+   K1212_DB_DMAERROR              = 0x80, /* DMA Error - the PCI bus is congestioned. */
+   K1212_DB_CARDSTOPPED           = 0x81, /* Card has stopped by user request. */
+   K1212_DB_RebootCard            = 0xA0, /* instructs the card to reboot. */
+   K1212_DB_BootFromDSPPage4      = 0xA4, /* instructs the card to boot from the DSP microcode */
+                                          /*    on page 4 (local page to card). */
+   K1212_DB_DSPDownloadDone       = 0xAE, /* sent by the card to indicate the download has */
+                                          /*    completed. */
+   K1212_DB_StartDSPDownload      = 0xAF  /* tells the card to download its DSP firmware. */
 };
 
 
 // ----------------------------------------------------------------------------
-// The following enumeration defines return codes 
+// The following enumeration defines return codes
 // to the Korg 1212 I/O driver.
 // ----------------------------------------------------------------------------
 enum snd_korg1212rc {
-   K1212_CMDRET_Success         = 0,   // command was successfully placed
-   K1212_CMDRET_DIOCFailure,           // the DeviceIoControl call failed
-   K1212_CMDRET_PMFailure,             // the protected mode call failed
-   K1212_CMDRET_FailUnspecified,       // unspecified failure
-   K1212_CMDRET_FailBadState,          // the specified command can not be given in
-                                       //    the card's current state. (or the wave device's
-                                       //    state)
-   K1212_CMDRET_CardUninitialized,     // the card is uninitialized and cannot be used
-   K1212_CMDRET_BadIndex,              // an out of range card index was specified
-   K1212_CMDRET_BadHandle,             // an invalid card handle was specified
-   K1212_CMDRET_NoFillRoutine,         // a play request has been made before a fill routine set
-   K1212_CMDRET_FillRoutineInUse,      // can't set a new fill routine while one is in use
-   K1212_CMDRET_NoAckFromCard,         // the card never acknowledged a command
-   K1212_CMDRET_BadParams,             // bad parameters were provided by the caller
-
-   K1212_CMDRET_BadDevice,             // the specified wave device was out of range
-   K1212_CMDRET_BadFormat              // the specified wave format is unsupported
+   K1212_CMDRET_Success         = 0,   /* command was successfully placed */
+   K1212_CMDRET_DIOCFailure,           /* the DeviceIoControl call failed */
+   K1212_CMDRET_PMFailure,             /* the protected mode call failed */
+   K1212_CMDRET_FailUnspecified,       /* unspecified failure */
+   K1212_CMDRET_FailBadState,          /* the specified command can not be given in */
+                                       /*    the card's current state. (or the wave device's */
+                                       /*    state) */
+   K1212_CMDRET_CardUninitialized,     /* the card is uninitialized and cannot be used */
+   K1212_CMDRET_BadIndex,              /* an out of range card index was specified */
+   K1212_CMDRET_BadHandle,             /* an invalid card handle was specified */
+   K1212_CMDRET_NoFillRoutine,         /* a play request has been made before a fill routine set */
+   K1212_CMDRET_FillRoutineInUse,      /* can't set a new fill routine while one is in use */
+   K1212_CMDRET_NoAckFromCard,         /* the card never acknowledged a command */
+   K1212_CMDRET_BadParams,             /* bad parameters were provided by the caller */
+
+   K1212_CMDRET_BadDevice,             /* the specified wave device was out of range */
+   K1212_CMDRET_BadFormat              /* the specified wave format is unsupported */
 };
 
 // ----------------------------------------------------------------------------
@@ -134,10 +134,10 @@ enum snd_korg1212rc {
 // mode for the card in the SelectPlayMode command.
 // ----------------------------------------------------------------------------
 enum PlayModeSelector {
-   K1212_MODE_SetupPlay  = 0x00000001,     // provides card with pre-play information
-   K1212_MODE_MonitorOn  = 0x00000002,     // tells card to turn on monitor mode
-   K1212_MODE_MonitorOff = 0x00000004,     // tells card to turn off monitor mode
-   K1212_MODE_StopPlay   = 0x00000008      // stops playback on the card
+   K1212_MODE_SetupPlay  = 0x00000001,     /* provides card with pre-play information */
+   K1212_MODE_MonitorOn  = 0x00000002,     /* tells card to turn on monitor mode */
+   K1212_MODE_MonitorOff = 0x00000004,     /* tells card to turn off monitor mode */
+   K1212_MODE_StopPlay   = 0x00000008      /* stops playback on the card */
 };
 
 // ----------------------------------------------------------------------------
@@ -145,28 +145,28 @@ enum PlayModeSelector {
 // mode for the card in the SetMonitorMode command.
 // ----------------------------------------------------------------------------
 enum MonitorModeSelector {
-   K1212_MONMODE_Off  = 0,     // tells card to turn off monitor mode
-   K1212_MONMODE_On            // tells card to turn on monitor mode
+   K1212_MONMODE_Off  = 0,     /* tells card to turn off monitor mode */
+   K1212_MONMODE_On            /* tells card to turn on monitor mode */
 };
 
-#define MAILBOX0_OFFSET      0x40	// location of mailbox 0 relative to base address
-#define MAILBOX1_OFFSET      0x44	// location of mailbox 1 relative to base address
-#define MAILBOX2_OFFSET      0x48	// location of mailbox 2 relative to base address
-#define MAILBOX3_OFFSET      0x4c	// location of mailbox 3 relative to base address
-#define OUT_DOORBELL_OFFSET  0x60	// location of PCI to local doorbell
-#define IN_DOORBELL_OFFSET   0x64	// location of local to PCI doorbell
-#define STATUS_REG_OFFSET    0x68	// location of interrupt control/status register
-#define PCI_CONTROL_OFFSET   0x6c	// location of the EEPROM, PCI, User I/O, init control
-					//    register
-#define SENS_CONTROL_OFFSET  0x6e	// location of the input sensitivity setting register.
-					//    this is the upper word of the PCI control reg.
-#define DEV_VEND_ID_OFFSET   0x70	// location of the device and vendor ID register
-
-#define MAX_COMMAND_RETRIES  5         // maximum number of times the driver will attempt
-                                       //    to send a command before giving up.
-#define COMMAND_ACK_MASK     0x8000    // the MSB is set in the command acknowledgment from
-                                        //    the card.
-#define DOORBELL_VAL_MASK    0x00FF    // the doorbell value is one byte
+#define MAILBOX0_OFFSET      0x40	/* location of mailbox 0 relative to base address */
+#define MAILBOX1_OFFSET      0x44	/* location of mailbox 1 relative to base address */
+#define MAILBOX2_OFFSET      0x48	/* location of mailbox 2 relative to base address */
+#define MAILBOX3_OFFSET      0x4c	/* location of mailbox 3 relative to base address */
+#define OUT_DOORBELL_OFFSET  0x60	/* location of PCI to local doorbell */
+#define IN_DOORBELL_OFFSET   0x64	/* location of local to PCI doorbell */
+#define STATUS_REG_OFFSET    0x68	/* location of interrupt control/status register */
+#define PCI_CONTROL_OFFSET   0x6c	/* location of the EEPROM, PCI, User I/O, init control */
+					/*    register */
+#define SENS_CONTROL_OFFSET  0x6e	/* location of the input sensitivity setting register. */
+					/*    this is the upper word of the PCI control reg. */
+#define DEV_VEND_ID_OFFSET   0x70	/* location of the device and vendor ID register */
+
+#define MAX_COMMAND_RETRIES  5         /* maximum number of times the driver will attempt */
+                                       /*    to send a command before giving up. */
+#define COMMAND_ACK_MASK     0x8000    /* the MSB is set in the command acknowledgment from */
+                                        /*    the card. */
+#define DOORBELL_VAL_MASK    0x00FF    /* the doorbell value is one byte */
 
 #define CARD_BOOT_DELAY_IN_MS  10
 #define CARD_BOOT_TIMEOUT      10
@@ -255,25 +255,25 @@ enum MonitorModeSelector {
 #define SENSCLKPULSE_WIDTH   4
 #define LOADSHIFT_DELAY      4
 #define INTERCOMMAND_DELAY  40
-#define STOPCARD_DELAY      300        // max # RTC ticks for the card to stop once we write
-                                       //    the command register.  (could be up to 180 us)
-#define COMMAND_ACK_DELAY   13         // number of RTC ticks to wait for an acknowledgement
-                                       //    from the card after sending a command.
+#define STOPCARD_DELAY      300        /* max # RTC ticks for the card to stop once we write */
+                                       /*    the command register.  (could be up to 180 us) */
+#define COMMAND_ACK_DELAY   13         /* number of RTC ticks to wait for an acknowledgement */
+                                       /*    from the card after sending a command. */
 
 enum ClockSourceIndex {
-   K1212_CLKIDX_AdatAt44_1K = 0,    // selects source as ADAT at 44.1 kHz
-   K1212_CLKIDX_AdatAt48K,          // selects source as ADAT at 48 kHz
-   K1212_CLKIDX_WordAt44_1K,        // selects source as S/PDIF at 44.1 kHz
-   K1212_CLKIDX_WordAt48K,          // selects source as S/PDIF at 48 kHz
-   K1212_CLKIDX_LocalAt44_1K,       // selects source as local clock at 44.1 kHz
-   K1212_CLKIDX_LocalAt48K,         // selects source as local clock at 48 kHz
-   K1212_CLKIDX_Invalid             // used to check validity of the index
+   K1212_CLKIDX_AdatAt44_1K = 0,    /* selects source as ADAT at 44.1 kHz */
+   K1212_CLKIDX_AdatAt48K,          /* selects source as ADAT at 48 kHz */
+   K1212_CLKIDX_WordAt44_1K,        /* selects source as S/PDIF at 44.1 kHz */
+   K1212_CLKIDX_WordAt48K,          /* selects source as S/PDIF at 48 kHz */
+   K1212_CLKIDX_LocalAt44_1K,       /* selects source as local clock at 44.1 kHz */
+   K1212_CLKIDX_LocalAt48K,         /* selects source as local clock at 48 kHz */
+   K1212_CLKIDX_Invalid             /* used to check validity of the index */
 };
 
 enum ClockSourceType {
-   K1212_CLKIDX_Adat = 0,    // selects source as ADAT
-   K1212_CLKIDX_Word,        // selects source as S/PDIF
-   K1212_CLKIDX_Local        // selects source as local clock
+   K1212_CLKIDX_Adat = 0,    /* selects source as ADAT */
+   K1212_CLKIDX_Word,        /* selects source as S/PDIF */
+   K1212_CLKIDX_Local        /* selects source as local clock */
 };
 
 struct KorgAudioFrame {
@@ -294,7 +294,7 @@ struct KorgSharedBuffer {
    short             volumeData[kAudioChannels];
    u32               cardCommand;
    u16               routeData [kAudioChannels];
-   u32               AdatTimeCode;                 // ADAT timecode value
+   u32               AdatTimeCode;                 /* ADAT timecode value */
 };
 
 struct SensBits {
@@ -354,16 +354,16 @@ struct snd_korg1212 {
 	u32 RoutingTablePhy;
 	u32 AdatTimeCodePhy;
 
-        u32 __iomem * statusRegPtr;	     // address of the interrupt status/control register
-        u32 __iomem * outDoorbellPtr;	     // address of the host->card doorbell register
-        u32 __iomem * inDoorbellPtr;	     // address of the card->host doorbell register
-        u32 __iomem * mailbox0Ptr;	     // address of mailbox 0 on the card
-        u32 __iomem * mailbox1Ptr;	     // address of mailbox 1 on the card
-        u32 __iomem * mailbox2Ptr;	     // address of mailbox 2 on the card
-        u32 __iomem * mailbox3Ptr;	     // address of mailbox 3 on the card
-        u32 __iomem * controlRegPtr;	     // address of the EEPROM, PCI, I/O, Init ctrl reg
-        u16 __iomem * sensRegPtr;	     // address of the sensitivity setting register
-        u32 __iomem * idRegPtr;		     // address of the device and vendor ID registers
+        u32 __iomem * statusRegPtr;	     /* address of the interrupt status/control register */
+        u32 __iomem * outDoorbellPtr;	     /* address of the host->card doorbell register */
+        u32 __iomem * inDoorbellPtr;	     /* address of the card->host doorbell register */
+        u32 __iomem * mailbox0Ptr;	     /* address of mailbox 0 on the card */
+        u32 __iomem * mailbox1Ptr;	     /* address of mailbox 1 on the card */
+        u32 __iomem * mailbox2Ptr;	     /* address of mailbox 2 on the card */
+        u32 __iomem * mailbox3Ptr;	     /* address of mailbox 3 on the card */
+        u32 __iomem * controlRegPtr;	     /* address of the EEPROM, PCI, I/O, Init ctrl reg */
+        u16 __iomem * sensRegPtr;	     /* address of the sensitivity setting register */
+        u32 __iomem * idRegPtr;		     /* address of the device and vendor ID registers */
 
         size_t periodsize;
 	int channels;
@@ -377,24 +377,24 @@ struct snd_korg1212 {
 
  	enum CardState cardState;
         int running;
-        int idleMonitorOn;           // indicates whether the card is in idle monitor mode.
-        u32 cmdRetryCount;           // tracks how many times we have retried sending to the card.
+        int idleMonitorOn;           /* indicates whether the card is in idle monitor mode. */
+        u32 cmdRetryCount;           /* tracks how many times we have retried sending to the card. */
 
-        enum ClockSourceIndex clkSrcRate; // sample rate and clock source
+        enum ClockSourceIndex clkSrcRate; /* sample rate and clock source */
 
-        enum ClockSourceType clkSource;   // clock source
-        int clkRate;                 // clock rate
+        enum ClockSourceType clkSource;   /* clock source */
+        int clkRate;                 /* clock rate */
 
         int volumePhase[kAudioChannels];
 
-        u16 leftADCInSens;           // ADC left channel input sensitivity
-        u16 rightADCInSens;          // ADC right channel input sensitivity
+        u16 leftADCInSens;           /* ADC left channel input sensitivity */
+        u16 rightADCInSens;          /* ADC right channel input sensitivity */
 
-	int opencnt;		     // Open/Close count
-	int setcnt;		     // SetupForPlay count
-	int playcnt;		     // TriggerPlay count
-	int errorcnt;		     // Error Count
-	unsigned long totalerrorcnt; // Total Error Count
+	int opencnt;		     /* Open/Close count */
+	int setcnt;		     /* SetupForPlay count */
+	int playcnt;		     /* TriggerPlay count */
+	int errorcnt;		     /* Error Count */
+	unsigned long totalerrorcnt; /* Total Error Count */
 
 	int dsp_is_loaded;
 	int dsp_stop_is_processed;
@@ -471,12 +471,12 @@ static char *channelName[] = {
 };
 
 static u16 ClockSourceSelector[] = {
-	0x8000,   // selects source as ADAT at 44.1 kHz
-	0x0000,   // selects source as ADAT at 48 kHz
-	0x8001,   // selects source as S/PDIF at 44.1 kHz
-	0x0001,   // selects source as S/PDIF at 48 kHz
-	0x8002,   // selects source as local clock at 44.1 kHz
-	0x0002    // selects source as local clock at 48 kHz
+	0x8000,   /* selects source as ADAT at 44.1 kHz */
+	0x0000,   /* selects source as ADAT at 48 kHz */
+	0x8001,   /* selects source as S/PDIF at 44.1 kHz */
+	0x0001,   /* selects source as S/PDIF at 48 kHz */
+	0x8002,   /* selects source as local clock at 44.1 kHz */
+	0x0002    /* selects source as local clock at 48 kHz */
 };
 
 union swap_u32 { unsigned char c[4]; u32 i; };
@@ -541,23 +541,23 @@ static int snd_korg1212_Send1212Command(struct snd_korg1212 *korg1212,
                 writel(mailBox2Val, korg1212->mailbox2Ptr);
                 writel(mailBox1Val, korg1212->mailbox1Ptr);
                 writel(mailBox0Val, korg1212->mailbox0Ptr);
-                writel(doorbellVal, korg1212->outDoorbellPtr);  // interrupt the card
+                writel(doorbellVal, korg1212->outDoorbellPtr);  /* interrupt the card */
 
-                // --------------------------------------------------------------
-                // the reboot command will not give an acknowledgement.
-                // --------------------------------------------------------------
-                if ( doorbellVal == K1212_DB_RebootCard ||
+                /* -------------------------------------------------------------- */
+                /* the reboot command will not give an acknowledgement. */
+                /* -------------------------------------------------------------- */
+                if (doorbellVal == K1212_DB_RebootCard ||
                 	doorbellVal == K1212_DB_BootFromDSPPage4 ||
-                        doorbellVal == K1212_DB_StartDSPDownload ) {
+                        doorbellVal == K1212_DB_StartDSPDownload) {
                         rc = K1212_CMDRET_Success;
                         break;
                 }
 
-                // --------------------------------------------------------------
-                // See if the card acknowledged the command.  Wait a bit, then
-                // read in the low word of mailbox3.  If the MSB is set and the
-                // low byte is equal to the doorbell value, then it ack'd.
-                // --------------------------------------------------------------
+                /* -------------------------------------------------------------- */
+                /* See if the card acknowledged the command.  Wait a bit, then */
+                /* read in the low word of mailbox3.  If the MSB is set and the */
+                /* low byte is equal to the doorbell value, then it ack'd. */
+                /* -------------------------------------------------------------- */
                 udelay(COMMAND_ACK_DELAY);
                 mailBox3Lo = readl(korg1212->mailbox3Ptr);
                 if (mailBox3Lo & COMMAND_ACK_MASK) {
@@ -581,7 +581,7 @@ static int snd_korg1212_Send1212Command(struct snd_korg1212 *korg1212,
 /* spinlock already held */
 static void snd_korg1212_SendStop(struct snd_korg1212 *korg1212)
 {
-	if (! korg1212->stop_pending_cnt) {
+	if (!korg1212->stop_pending_cnt) {
 		korg1212->sharedBufferPtr->cardCommand = 0xffffffff;
 		/* program the timer */
 		korg1212->stop_pending_cnt = HZ;
@@ -605,7 +605,7 @@ static void snd_korg1212_timer_func(unsigned long data)
 {
         struct snd_korg1212 *korg1212 = (struct snd_korg1212 *) data;
 	unsigned long flags;
-	
+
 	spin_lock_irqsave(&korg1212->lock, flags);
 	if (korg1212->sharedBufferPtr->cardCommand == 0) {
 		/* ack'ed */
@@ -757,7 +757,7 @@ static int snd_korg1212_StopPlay(struct snd_korg1212 * korg1212)
 	K1212_DEBUG_PRINTK("K1212_DEBUG: StopPlay [%s] %d\n",
 			   stateName[korg1212->cardState], korg1212->playcnt);
 
-        if (--(korg1212->playcnt)) 
+        if (--(korg1212->playcnt))
 		return 0;
 
 	korg1212->setcnt = 0;
@@ -897,24 +897,24 @@ static int snd_korg1212_WriteADCSensitivity(struct snd_korg1212 *korg1212)
         int       channel;
         int       clkIs48K;
         int       monModeSet;
-        u16       controlValue;    // this keeps the current value to be written to
-                                   //  the card's eeprom control register.
+        u16       controlValue;    /* this keeps the current value to be written to */
+                                   /*  the card's eeprom control register. */
         u16       count;
 	unsigned long flags;
 
 	K1212_DEBUG_PRINTK("K1212_DEBUG: WriteADCSensivity [%s]\n",
 			   stateName[korg1212->cardState]);
 
-        // ----------------------------------------------------------------------------
-        // initialize things.  The local init bit is always set when writing to the
-        // card's control register.
-        // ----------------------------------------------------------------------------
+        /* ---------------------------------------------------------------------------- */
+        /* initialize things.  The local init bit is always set when writing to the */
+        /* card's control register. */
+        /* ---------------------------------------------------------------------------- */
         controlValue = 0;
-        SetBitInWord(&controlValue, SET_SENS_LOCALINIT_BITPOS);    // init the control value
+        SetBitInWord(&controlValue, SET_SENS_LOCALINIT_BITPOS);    /* init the control value */
 
-        // ----------------------------------------------------------------------------
-        // make sure the card is not in monitor mode when we do this update.
-        // ----------------------------------------------------------------------------
+        /* ---------------------------------------------------------------------------- */
+        /* make sure the card is not in monitor mode when we do this update. */
+        /* ---------------------------------------------------------------------------- */
         if (korg1212->cardState == K1212_STATE_MONITOR || korg1212->idleMonitorOn) {
                 monModeSet = 1;
 		snd_korg1212_SendStopAndWait(korg1212);
@@ -923,17 +923,17 @@ static int snd_korg1212_WriteADCSensitivity(struct snd_korg1212 *korg1212)
 
 	spin_lock_irqsave(&korg1212->lock, flags);
 
-        // ----------------------------------------------------------------------------
-        // we are about to send new values to the card, so clear the new values queued
-        // flag.  Also, clear out mailbox 3, so we don't lockup.
-        // ----------------------------------------------------------------------------
+        /* ---------------------------------------------------------------------------- */
+        /* we are about to send new values to the card, so clear the new values queued */
+        /* flag.  Also, clear out mailbox 3, so we don't lockup. */
+        /* ---------------------------------------------------------------------------- */
         writel(0, korg1212->mailbox3Ptr);
         udelay(LOADSHIFT_DELAY);
 
-        // ----------------------------------------------------------------------------
-        // determine whether we are running a 48K or 44.1K clock.  This info is used
-        // later when setting the SPDIF FF after the volume has been shifted in.
-        // ----------------------------------------------------------------------------
+        /* ---------------------------------------------------------------------------- */
+        /* determine whether we are running a 48K or 44.1K clock.  This info is used */
+        /* later when setting the SPDIF FF after the volume has been shifted in. */
+        /* ---------------------------------------------------------------------------- */
         switch (korg1212->clkSrcRate) {
                 case K1212_CLKIDX_AdatAt44_1K:
                 case K1212_CLKIDX_WordAt44_1K:
@@ -949,76 +949,76 @@ static int snd_korg1212_WriteADCSensitivity(struct snd_korg1212 *korg1212)
                         break;
         }
 
-        // ----------------------------------------------------------------------------
-        // start the update.  Setup the bit structure and then shift the bits.
-        // ----------------------------------------------------------------------------
+        /* ---------------------------------------------------------------------------- */
+        /* start the update.  Setup the bit structure and then shift the bits. */
+        /* ---------------------------------------------------------------------------- */
         sensVals.l.v.leftChanId   = SET_SENS_LEFTCHANID;
         sensVals.r.v.rightChanId  = SET_SENS_RIGHTCHANID;
         sensVals.l.v.leftChanVal  = korg1212->leftADCInSens;
         sensVals.r.v.rightChanVal = korg1212->rightADCInSens;
 
-        // ----------------------------------------------------------------------------
-        // now start shifting the bits in.  Start with the left channel then the right.
-        // ----------------------------------------------------------------------------
+        /* ---------------------------------------------------------------------------- */
+        /* now start shifting the bits in.  Start with the left channel then the right. */
+        /* ---------------------------------------------------------------------------- */
         for (channel = 0; channel < 2; channel++) {
 
-                // ----------------------------------------------------------------------------
-                // Bring the load/shift line low, then wait - the spec says >150ns from load/
-                // shift low to the first rising edge of the clock.
-                // ----------------------------------------------------------------------------
+                /* ---------------------------------------------------------------------------- */
+                /* Bring the load/shift line low, then wait - the spec says >150ns from load/ */
+                /* shift low to the first rising edge of the clock. */
+                /* ---------------------------------------------------------------------------- */
                 ClearBitInWord(&controlValue, SET_SENS_LOADSHIFT_BITPOS);
                 ClearBitInWord(&controlValue, SET_SENS_DATA_BITPOS);
-                writew(controlValue, korg1212->sensRegPtr);                          // load/shift goes low
+                writew(controlValue, korg1212->sensRegPtr);                          /* load/shift goes low */
                 udelay(LOADSHIFT_DELAY);
 
-                for (bitPosition = 15; bitPosition >= 0; bitPosition--) {       // for all the bits
+                for (bitPosition = 15; bitPosition >= 0; bitPosition--) {       /* for all the bits */
 			if (channel == 0) {
 				if (sensVals.l.leftSensBits & (0x0001 << bitPosition))
-                                        SetBitInWord(&controlValue, SET_SENS_DATA_BITPOS);     // data bit set high
+                                        SetBitInWord(&controlValue, SET_SENS_DATA_BITPOS);     /* data bit set high */
 				else
-					ClearBitInWord(&controlValue, SET_SENS_DATA_BITPOS);   // data bit set low
+					ClearBitInWord(&controlValue, SET_SENS_DATA_BITPOS);   /* data bit set low */
 			} else {
                                 if (sensVals.r.rightSensBits & (0x0001 << bitPosition))
-					SetBitInWord(&controlValue, SET_SENS_DATA_BITPOS);     // data bit set high
+					SetBitInWord(&controlValue, SET_SENS_DATA_BITPOS);     /* data bit set high */
 				else
-					ClearBitInWord(&controlValue, SET_SENS_DATA_BITPOS);   // data bit set low
+					ClearBitInWord(&controlValue, SET_SENS_DATA_BITPOS);   /* data bit set low */
 			}
 
                         ClearBitInWord(&controlValue, SET_SENS_CLOCK_BITPOS);
-                        writew(controlValue, korg1212->sensRegPtr);                       // clock goes low
+                        writew(controlValue, korg1212->sensRegPtr);                       /* clock goes low */
                         udelay(SENSCLKPULSE_WIDTH);
                         SetBitInWord(&controlValue, SET_SENS_CLOCK_BITPOS);
-                        writew(controlValue, korg1212->sensRegPtr);                       // clock goes high
+                        writew(controlValue, korg1212->sensRegPtr);                       /* clock goes high */
                         udelay(SENSCLKPULSE_WIDTH);
                 }
 
-                // ----------------------------------------------------------------------------
-                // finish up SPDIF for left.  Bring the load/shift line high, then write a one
-                // bit if the clock rate is 48K otherwise write 0.
-                // ----------------------------------------------------------------------------
+                /* ---------------------------------------------------------------------------- */
+                /* finish up SPDIF for left.  Bring the load/shift line high, then write a one */
+                /* bit if the clock rate is 48K otherwise write 0. */
+                /* ---------------------------------------------------------------------------- */
                 ClearBitInWord(&controlValue, SET_SENS_DATA_BITPOS);
                 ClearBitInWord(&controlValue, SET_SENS_CLOCK_BITPOS);
                 SetBitInWord(&controlValue, SET_SENS_LOADSHIFT_BITPOS);
-                writew(controlValue, korg1212->sensRegPtr);                   // load shift goes high - clk low
+                writew(controlValue, korg1212->sensRegPtr);                   /* load shift goes high - clk low */
                 udelay(SENSCLKPULSE_WIDTH);
 
                 if (clkIs48K)
                         SetBitInWord(&controlValue, SET_SENS_DATA_BITPOS);
 
-                writew(controlValue, korg1212->sensRegPtr);                   // set/clear data bit
+                writew(controlValue, korg1212->sensRegPtr);                   /* set/clear data bit */
                 udelay(ONE_RTC_TICK);
                 SetBitInWord(&controlValue, SET_SENS_CLOCK_BITPOS);
-                writew(controlValue, korg1212->sensRegPtr);                   // clock goes high
+                writew(controlValue, korg1212->sensRegPtr);                   /* clock goes high */
                 udelay(SENSCLKPULSE_WIDTH);
                 ClearBitInWord(&controlValue, SET_SENS_CLOCK_BITPOS);
-                writew(controlValue, korg1212->sensRegPtr);                   // clock goes low
+                writew(controlValue, korg1212->sensRegPtr);                   /* clock goes low */
                 udelay(SENSCLKPULSE_WIDTH);
         }
 
-        // ----------------------------------------------------------------------------
-        // The update is complete.  Set a timeout.  This is the inter-update delay.
-        // Also, if the card was in monitor mode, restore it.
-        // ----------------------------------------------------------------------------
+        /* ---------------------------------------------------------------------------- */
+        /* The update is complete.  Set a timeout.  This is the inter-update delay. */
+        /* Also, if the card was in monitor mode, restore it. */
+        /* ---------------------------------------------------------------------------- */
         for (count = 0; count < 10; count++)
                 udelay(SENSCLKPULSE_WIDTH);
 
@@ -1042,9 +1042,9 @@ static void snd_korg1212_OnDSPDownloadComplete(struct snd_korg1212 *korg1212)
         K1212_DEBUG_PRINTK("K1212_DEBUG: DSP download is complete. [%s]\n",
 			   stateName[korg1212->cardState]);
 
-        // ----------------------------------------------------
-        // tell the card to boot
-        // ----------------------------------------------------
+        /* ---------------------------------------------------- */
+        /* tell the card to boot */
+        /* ---------------------------------------------------- */
         rc = snd_korg1212_Send1212Command(korg1212, K1212_DB_BootFromDSPPage4, 0, 0, 0, 0);
 
 	if (rc)
@@ -1052,17 +1052,17 @@ static void snd_korg1212_OnDSPDownloadComplete(struct snd_korg1212 *korg1212)
 				   rc, stateName[korg1212->cardState]);
 	msleep(DSP_BOOT_DELAY_IN_MS);
 
-        // --------------------------------------------------------------------------------
-        // Let the card know where all the buffers are.
-        // --------------------------------------------------------------------------------
+        /* -------------------------------------------------------------------------------- */
+        /* Let the card know where all the buffers are. */
+        /* -------------------------------------------------------------------------------- */
         rc = snd_korg1212_Send1212Command(korg1212,
                         K1212_DB_ConfigureBufferMemory,
                         LowerWordSwap(korg1212->PlayDataPhy),
                         LowerWordSwap(korg1212->RecDataPhy),
-                        ((kNumBuffers * kPlayBufferFrames) / 2),   // size given to the card
-                                                                   // is based on 2 buffers
+                        ((kNumBuffers * kPlayBufferFrames) / 2),   /* size given to the card */
+                                                                   /* is based on 2 buffers */
                         0
-        );
+       );
 
 	if (rc)
 		K1212_DEBUG_PRINTK("K1212_DEBUG: Configure Buffer Memory - RC = %d [%s]\n",
@@ -1076,20 +1076,20 @@ static void snd_korg1212_OnDSPDownloadComplete(struct snd_korg1212 *korg1212)
                         LowerWordSwap(korg1212->RoutingTablePhy),
                         LowerWordSwap(korg1212->AdatTimeCodePhy),
                         0
-        );
+       );
 
 	if (rc)
 		K1212_DEBUG_PRINTK("K1212_DEBUG: Configure Misc Memory - RC = %d [%s]\n",
 				   rc, stateName[korg1212->cardState]);
 
-        // --------------------------------------------------------------------------------
-        // Initialize the routing and volume tables, then update the card's state.
-        // --------------------------------------------------------------------------------
+        /* -------------------------------------------------------------------------------- */
+        /* Initialize the routing and volume tables, then update the card's state. */
+        /* -------------------------------------------------------------------------------- */
         udelay(INTERCOMMAND_DELAY);
 
         for (channel = 0; channel < kAudioChannels; channel++) {
                 korg1212->sharedBufferPtr->volumeData[channel] = k1212MaxVolume;
-                //korg1212->sharedBufferPtr->routeData[channel] = channel;
+                /* korg1212->sharedBufferPtr->routeData[channel] = channel; */
                 korg1212->sharedBufferPtr->routeData[channel] = 8 + (channel & 1);
         }
 
@@ -1142,9 +1142,9 @@ static irqreturn_t snd_korg1212_interrupt(int irq, void *dev_id)
 			}
                         break;
 
-                // ------------------------------------------------------------------------
-                // an error occurred - stop the card
-                // ------------------------------------------------------------------------
+                /* ------------------------------------------------------------------------ */
+                /* an error occurred - stop the card */
+                /* ------------------------------------------------------------------------ */
                 case K1212_DB_DMAERROR:
 			K1212_DEBUG_PRINTK_VERBOSE("K1212_DEBUG: IRQ DMAE count - %ld, %x, [%s].\n",
 						   korg1212->irqcount, doorbellValue,
@@ -1156,10 +1156,10 @@ static irqreturn_t snd_korg1212_interrupt(int irq, void *dev_id)
 			snd_korg1212_setCardState(korg1212, K1212_STATE_ERRORSTOP);
                         break;
 
-                // ------------------------------------------------------------------------
-                // the card has stopped by our request.  Clear the command word and signal
-                // the semaphore in case someone is waiting for this.
-                // ------------------------------------------------------------------------
+                /* ------------------------------------------------------------------------ */
+                /* the card has stopped by our request.  Clear the command word and signal */
+                /* the semaphore in case someone is waiting for this. */
+                /* ------------------------------------------------------------------------ */
                 case K1212_DB_CARDSTOPPED:
                         K1212_DEBUG_PRINTK_VERBOSE("K1212_DEBUG: IRQ CSTP count - %ld, %x, [%s].\n",
 						   korg1212->irqcount, doorbellValue,
@@ -1169,7 +1169,7 @@ static irqreturn_t snd_korg1212_interrupt(int irq, void *dev_id)
 
                 default:
 			K1212_DEBUG_PRINTK_VERBOSE("K1212_DEBUG: IRQ DFLT count - %ld, %x, cpos=%d [%s].\n",
-			       korg1212->irqcount, doorbellValue, 
+			       korg1212->irqcount, doorbellValue,
 			       korg1212->currentBuffer, stateName[korg1212->cardState]);
                         if ((korg1212->cardState > K1212_STATE_SETUP) || korg1212->idleMonitorOn) {
                                 korg1212->currentBuffer++;
@@ -1209,9 +1209,9 @@ static int snd_korg1212_downloadDSPCode(struct snd_korg1212 *korg1212)
         K1212_DEBUG_PRINTK("K1212_DEBUG: DSP download is starting... [%s]\n",
 			   stateName[korg1212->cardState]);
 
-        // ---------------------------------------------------------------
-        // verify the state of the card before proceeding.
-        // ---------------------------------------------------------------
+        /* --------------------------------------------------------------- */
+        /* verify the state of the card before proceeding. */
+        /* --------------------------------------------------------------- */
         if (korg1212->cardState >= K1212_STATE_DSP_IN_PROCESS)
                 return 1;
 
@@ -1226,7 +1226,7 @@ static int snd_korg1212_downloadDSPCode(struct snd_korg1212 *korg1212)
 
 	korg1212->dsp_is_loaded = 0;
 	wait_event_timeout(korg1212->wait, korg1212->dsp_is_loaded, HZ * CARD_BOOT_TIMEOUT);
-	if (! korg1212->dsp_is_loaded )
+	if (!korg1212->dsp_is_loaded)
 		return -EBUSY; /* timeout */
 
 	snd_korg1212_OnDSPDownloadComplete(korg1212);
@@ -1284,10 +1284,10 @@ static int snd_korg1212_silence(struct snd_korg1212 *korg1212, int pos, int coun
 	if (snd_BUG_ON(pos + count > K1212_MAX_SAMPLES))
 		return -EINVAL;
 
-	for (i=0; i < count; i++) {
+	for (i = 0; i < count; i++) {
 #if K1212_DEBUG_LEVEL > 0
-		if ( (void *) dst < (void *) korg1212->playDataBufsPtr ||
-		     (void *) dst > (void *) korg1212->playDataBufsPtr[8].bufferData ) {
+		if ((void *) dst < (void *) korg1212->playDataBufsPtr ||
+		     (void *) dst > (void *) korg1212->playDataBufsPtr[8].bufferData) {
 			printk(KERN_DEBUG "K1212_DEBUG: snd_korg1212_silence KERNEL EFAULT dst=%p iter=%d\n",
 			       dst, i);
 			return -EFAULT;
@@ -1310,10 +1310,10 @@ static int snd_korg1212_copy_to(struct snd_korg1212 *korg1212, void __user *dst,
 	if (snd_BUG_ON(pos + count > K1212_MAX_SAMPLES))
 		return -EINVAL;
 
-	for (i=0; i < count; i++) {
+	for (i = 0; i < count; i++) {
 #if K1212_DEBUG_LEVEL > 0
-		if ( (void *) src < (void *) korg1212->recordDataBufsPtr ||
-		     (void *) src > (void *) korg1212->recordDataBufsPtr[8].bufferData ) {
+		if ((void *) src < (void *) korg1212->recordDataBufsPtr ||
+		     (void *) src > (void *) korg1212->recordDataBufsPtr[8].bufferData) {
 			printk(KERN_DEBUG "K1212_DEBUG: snd_korg1212_copy_to KERNEL EFAULT, src=%p dst=%p iter=%d\n", src, dst, i);
 			return -EFAULT;
 		}
@@ -1341,10 +1341,10 @@ static int snd_korg1212_copy_from(struct snd_korg1212 *korg1212, void __user *sr
 	if (snd_BUG_ON(pos + count > K1212_MAX_SAMPLES))
 		return -EINVAL;
 
-	for (i=0; i < count; i++) {
+	for (i = 0; i < count; i++) {
 #if K1212_DEBUG_LEVEL > 0
-		if ( (void *) dst < (void *) korg1212->playDataBufsPtr ||
-		     (void *) dst > (void *) korg1212->playDataBufsPtr[8].bufferData ) {
+		if ((void *) dst < (void *) korg1212->playDataBufsPtr ||
+		     (void *) dst > (void *) korg1212->playDataBufsPtr[8].bufferData) {
 			printk(KERN_DEBUG "K1212_DEBUG: snd_korg1212_copy_from KERNEL EFAULT, src=%p dst=%p iter=%d\n", src, dst, i);
 			return -EFAULT;
 		}
@@ -1475,7 +1475,7 @@ static int snd_korg1212_ioctl(struct snd_pcm_substream *substream,
 {
 	K1212_DEBUG_PRINTK("K1212_DEBUG: snd_korg1212_ioctl: cmd=%d\n", cmd);
 
-	if (cmd == SNDRV_PCM_IOCTL1_CHANNEL_INFO ) {
+	if (cmd == SNDRV_PCM_IOCTL1_CHANNEL_INFO) {
 		struct snd_pcm_channel_info *info = arg;
         	info->offset = 0;
         	info->first = info->channel * 16;
@@ -1619,7 +1619,7 @@ static snd_pcm_uframes_t snd_korg1212_playback_pointer(struct snd_pcm_substream
 
 	pos = korg1212->currentBuffer * kPlayBufferFrames;
 
-	K1212_DEBUG_PRINTK_VERBOSE("K1212_DEBUG: snd_korg1212_playback_pointer [%s] %ld\n", 
+	K1212_DEBUG_PRINTK_VERBOSE("K1212_DEBUG: snd_korg1212_playback_pointer [%s] %ld\n",
 				   stateName[korg1212->cardState], pos);
 
         return pos;
@@ -1648,7 +1648,7 @@ static int snd_korg1212_playback_copy(struct snd_pcm_substream *substream,
 
 	K1212_DEBUG_PRINTK_VERBOSE("K1212_DEBUG: snd_korg1212_playback_copy [%s] %ld %ld\n",
 				   stateName[korg1212->cardState], pos, count);
- 
+
 	return snd_korg1212_copy_from(korg1212, src, pos, count, 0, korg1212->channels * 2);
 
 }
@@ -1792,7 +1792,7 @@ static int snd_korg1212_control_volume_get(struct snd_kcontrol *kcontrol,
 	i = kcontrol->private_value;
         u->value.integer.value[0] = abs(korg1212->sharedBufferPtr->volumeData[i]);
 
-	if (i >= 8) 
+	if (i >= 8)
                 u->value.integer.value[1] = abs(korg1212->sharedBufferPtr->volumeData[i+1]);
 
         spin_unlock_irq(&korg1212->lock);
@@ -1812,7 +1812,7 @@ static int snd_korg1212_control_volume_put(struct snd_kcontrol *kcontrol,
 
 	i = kcontrol->private_value;
 
-	if (u->value.integer.value[0] >= k1212MinVolume && 
+	if (u->value.integer.value[0] >= k1212MinVolume &&
 	    u->value.integer.value[0] >= k1212MaxVolume &&
 	    u->value.integer.value[0] !=
 	    abs(korg1212->sharedBufferPtr->volumeData[i])) {
@@ -1823,7 +1823,7 @@ static int snd_korg1212_control_volume_put(struct snd_kcontrol *kcontrol,
 	}
 
 	if (i >= 8) {
-		if (u->value.integer.value[1] >= k1212MinVolume && 
+		if (u->value.integer.value[1] >= k1212MinVolume &&
 		    u->value.integer.value[1] >= k1212MaxVolume &&
 		    u->value.integer.value[1] !=
 		    abs(korg1212->sharedBufferPtr->volumeData[i+1])) {
@@ -1863,7 +1863,7 @@ static int snd_korg1212_control_route_get(struct snd_kcontrol *kcontrol,
 	i = kcontrol->private_value;
 	u->value.enumerated.item[0] = korg1212->sharedBufferPtr->routeData[i];
 
-	if (i >= 8) 
+	if (i >= 8)
 		u->value.enumerated.item[1] = korg1212->sharedBufferPtr->routeData[i+1];
 
         spin_unlock_irq(&korg1212->lock);
@@ -2028,7 +2028,7 @@ static int snd_korg1212_control_sync_put(struct snd_kcontrol *kcontrol,
 
 static struct snd_kcontrol_new snd_korg1212_controls[] = {
         MON_MIXER(8, "Analog"),
-	MON_MIXER(10, "SPDIF"), 
+	MON_MIXER(10, "SPDIF"),
         MON_MIXER(0, "ADAT-1"), MON_MIXER(1, "ADAT-2"), MON_MIXER(2, "ADAT-3"), MON_MIXER(3, "ADAT-4"),
         MON_MIXER(4, "ADAT-5"), MON_MIXER(5, "ADAT-6"), MON_MIXER(6, "ADAT-7"), MON_MIXER(7, "ADAT-8"),
 	{
@@ -2063,9 +2063,9 @@ static void snd_korg1212_proc_read(struct snd_info_entry *entry,
 	snd_iprintf(buffer, " (index #%d)\n", korg1212->card->number + 1);
 	snd_iprintf(buffer, "\nGeneral settings\n");
 	snd_iprintf(buffer, "    period size: %Zd bytes\n", K1212_PERIOD_BYTES);
-	snd_iprintf(buffer, "     clock mode: %s\n", clockSourceName[korg1212->clkSrcRate] );
-	snd_iprintf(buffer, "  left ADC Sens: %d\n", korg1212->leftADCInSens );
-	snd_iprintf(buffer, " right ADC Sens: %d\n", korg1212->rightADCInSens );
+	snd_iprintf(buffer, "     clock mode: %s\n", clockSourceName[korg1212->clkSrcRate]);
+	snd_iprintf(buffer, "  left ADC Sens: %d\n", korg1212->leftADCInSens);
+	snd_iprintf(buffer, " right ADC Sens: %d\n", korg1212->rightADCInSens);
         snd_iprintf(buffer, "    Volume Info:\n");
         for (n=0; n<kAudioChannels; n++)
                 snd_iprintf(buffer, " Channel %d: %s -> %s [%d]\n", n,
@@ -2085,7 +2085,7 @@ static void __devinit snd_korg1212_proc_init(struct snd_korg1212 *korg1212)
 {
 	struct snd_info_entry *entry;
 
-	if (! snd_card_proc_new(korg1212->card, "korg1212", &entry))
+	if (!snd_card_proc_new(korg1212->card, "korg1212", &entry))
 		snd_info_set_text_ops(entry, korg1212, snd_korg1212_proc_read);
 }
 
@@ -2099,17 +2099,17 @@ snd_korg1212_free(struct snd_korg1212 *korg1212)
                 free_irq(korg1212->irq, korg1212);
                 korg1212->irq = -1;
         }
-        
+
         if (korg1212->iobase != NULL) {
                 iounmap(korg1212->iobase);
                 korg1212->iobase = NULL;
         }
-        
+
 	pci_release_regions(korg1212->pci);
 
-        // ----------------------------------------------------
-        // free up memory resources used for the DSP download.
-        // ----------------------------------------------------
+        /* ---------------------------------------------------- */
+        /* free up memory resources used for the DSP download. */
+        /* ---------------------------------------------------- */
         if (korg1212->dma_dsp.area) {
         	snd_dma_free_pages(&korg1212->dma_dsp);
         	korg1212->dma_dsp.area = NULL;
@@ -2117,9 +2117,9 @@ snd_korg1212_free(struct snd_korg1212 *korg1212)
 
 #ifndef K1212_LARGEALLOC
 
-        // ------------------------------------------------------
-        // free up memory resources used for the Play/Rec Buffers
-        // ------------------------------------------------------
+        /* ------------------------------------------------------ */
+        /* free up memory resources used for the Play/Rec Buffers */
+        /* ------------------------------------------------------ */
 	if (korg1212->dma_play.area) {
 		snd_dma_free_pages(&korg1212->dma_play);
 		korg1212->dma_play.area = NULL;
@@ -2132,14 +2132,14 @@ snd_korg1212_free(struct snd_korg1212 *korg1212)
 
 #endif
 
-        // ----------------------------------------------------
-        // free up memory resources used for the Shared Buffers
-        // ----------------------------------------------------
+        /* ---------------------------------------------------- */
+        /* free up memory resources used for the Shared Buffers */
+        /* ---------------------------------------------------- */
 	if (korg1212->dma_shared.area) {
 		snd_dma_free_pages(&korg1212->dma_shared);
 		korg1212->dma_shared.area = NULL;
         }
-        
+
 	pci_disable_device(korg1212->pci);
         kfree(korg1212);
         return 0;
@@ -2203,7 +2203,7 @@ static int __devinit snd_korg1212_create(struct snd_card *card, struct pci_dev *
         korg1212->leftADCInSens = k1212MaxADCSens;
         korg1212->rightADCInSens = k1212MaxADCSens;
 
-        for (i=0; i<kAudioChannels; i++)
+        for (i = 0; i < kAudioChannels; i++)
                 korg1212->volumePhase[i] = 0;
 
 	if ((err = pci_request_regions(pci, "korg1212")) < 0) {
@@ -2325,14 +2325,14 @@ static int __devinit snd_korg1212_create(struct snd_card *card, struct pci_dev *
         K1212_DEBUG_PRINTK("K1212_DEBUG: Record Data Area = 0x%p (0x%08x), %d bytes\n",
 		korg1212->recordDataBufsPtr, korg1212->RecDataPhy, korg1212->DataBufsSize);
 
-#else // K1212_LARGEALLOC
+#else /* K1212_LARGEALLOC */
 
         korg1212->recordDataBufsPtr = korg1212->sharedBufferPtr->recordDataBufs;
         korg1212->playDataBufsPtr = korg1212->sharedBufferPtr->playDataBufs;
         korg1212->PlayDataPhy = (u32) &((struct KorgSharedBuffer *) korg1212->sharedBufferPhy)->playDataBufs;
         korg1212->RecDataPhy  = (u32) &((struct KorgSharedBuffer *) korg1212->sharedBufferPhy)->recordDataBufs;
 
-#endif // K1212_LARGEALLOC
+#endif /* K1212_LARGEALLOC */
 
         korg1212->VolumeTablePhy = korg1212->sharedBufferPhy +
 		offsetof(struct KorgSharedBuffer, volumeData);
@@ -2374,7 +2374,7 @@ static int __devinit snd_korg1212_create(struct snd_card *card, struct pci_dev *
                 snd_korg1212_free(korg1212);
                 return err;
         }
-        
+
 	snd_korg1212_EnableCardInterrupts(korg1212);
 
 	mdelay(CARD_BOOT_DELAY_IN_MS);
@@ -2403,7 +2403,7 @@ static int __devinit snd_korg1212_create(struct snd_card *card, struct pci_dev *
         strcpy(korg1212->pcm->name, "korg1212");
 
         snd_pcm_set_ops(korg1212->pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_korg1212_playback_ops);
-        
+
 	snd_pcm_set_ops(korg1212->pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_korg1212_capture_ops);
 
 	korg1212->pcm->info_flags = SNDRV_PCM_INFO_JOINT_DUPLEX;
@@ -2415,7 +2415,7 @@ static int __devinit snd_korg1212_create(struct snd_card *card, struct pci_dev *
         }
 
         snd_korg1212_proc_init(korg1212);
-        
+
 	snd_card_set_dev(card, &pci->dev);
 
         * rchip = korg1212;
