From: Rene Herman <rene.herman@gmail.com>
Subject: Re: Disable MIDI port creation with ICE1724
Date: Sun, 09 Sep 2007 02:23:33 +0200
Message-ID: <46E33D05.6080704@gmail.com>
References: <a98f20490709071832i7491b9bdl374e36ceee396087@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080300030608010505010009"
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <a98f20490709071832i7491b9bdl374e36ceee396087@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: James Roberts <jaaxxster@gmail.com>
Cc: alsa-user@lists.sourceforge.net, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080300030608010505010009
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 09/08/2007 03:32 AM, James Roberts wrote:

> I need to disable the creation of the ICEnsemble ICE1724 midi device on 
> my system.  I am using a off-brand card (see below) and accessing the 
> midi device crashes the system hard.
> 
> I have explored udev rules, kernel opts, etc ad nauseum to do this.
> 
> To be clear I do not want to use the midi capabilities of the sound card 
> at all, but want to keep the sound capabilities.
> 
> lspci:
> 00:09.0 Multimedia audio controller: VIA Technologies Inc. VT1720/24 
> [Envy24PT/HT] PCI Multi-Channel Audio Controller (rev 01)
> 
> amidi -l:
> Dir Device    Name
> IO  hw:0,0    ICEnsemble ICE1724 MIDI   <- this must be gone forever!
> IO  hw:1,0,0  BCF2000 MIDI 1
> IO  hw:1,0,1  BCF2000 MIDI 2
>  O  hw:1,0,2  BCF2000 MIDI 3
> 
> 
> It appears to get assigned to midiC0D0
> 
> Am I better off going the udev route and trying to somehow assign a null 
> value somewhere or is there a way to prevent alsa from creating it?
> 
> Maybe an alias?

Sounds like this may warrent a module parameter. Trivial, untested version 
below, but this needs a module maintainer to decide if there may be better 
ways to discriminate. Crossposted to alsa-devel...

(against 2.6.22.x).

Rene.


--------------080300030608010505010009
Content-Type: text/plain;
 name="ice1724-no_mpu401.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ice1724-no_mpu401.diff"

diff --git a/sound/pci/ice1712/ice1724.c b/sound/pci/ice1712/ice1724.c
index ee620de..1d64dcc 100644
--- a/sound/pci/ice1712/ice1724.c
+++ b/sound/pci/ice1712/ice1724.c
@@ -75,6 +75,7 @@ static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
 static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;		/* Enable this card */
 static char *model[SNDRV_CARDS];
+static int no_mpu401[SNDRV_CARDS];
 
 module_param_array(index, int, NULL, 0444);
 MODULE_PARM_DESC(index, "Index value for ICE1724 soundcard.");
@@ -84,6 +85,8 @@ module_param_array(enable, bool, NULL, 0444);
 MODULE_PARM_DESC(enable, "Enable ICE1724 soundcard.");
 module_param_array(model, charp, NULL, 0444);
 MODULE_PARM_DESC(model, "Use the given board model.");
+module_param_array(no_mpu401, int, NULL, 0444);
+MODULE_PARM_DESC(no_mpu401, "Mmf mmmff mmfmf mff mmfmmff.");
 
 
 /* Both VT1720 and VT1724 have the same PCI IDs */
@@ -2398,7 +2401,7 @@ static int __devinit snd_vt1724_probe(struct pci_dev *pci,
 		}
 	}
 
-	if (! c->no_mpu401) {
+	if (! c->no_mpu401 && ! no_mpu401[dev]) {
 		if (ice->eeprom.data[ICE_EEP2_SYSCONF] & VT1724_CFG_MPU401) {
 			if ((err = snd_mpu401_uart_new(card, 0, MPU401_HW_ICE1712,
 						       ICEREG1724(ice, MPU_CTRL),

--------------080300030608010505010009
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--------------080300030608010505010009
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-user

--------------080300030608010505010009--
