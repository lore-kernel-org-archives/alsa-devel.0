From: Ville Herva <vherva@v.iki.fi>
Subject: Re: ice1724 M-Audio Revolution 5.1 support?
Date: Tue, 18 Oct 2005 12:31:39 +0300
Message-ID: <20051018093139.GA19128@v.iki.fi>
References: <20051017192155.GA16945@v.iki.fi>
Reply-To: Ville Herva <Ville.Herva@iki.fi>,
	alsa-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jI8keyz6grp/JLjh"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20051017192155.GA16945@v.iki.fi>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 17, 2005 at 10:21:56PM +0300, you [Ville Herva] wrote:
> Hi,
>  
> is support for M-Audio Revolution 5.1 planned? It appears quite similar to
> 7.1. I tried the monkey-see-monkey-do approach, and simply added the device
> ID to the driver (see the attached patch against 2.6.14-rc4), but that
> doesn't quite work - I get
>  
>    alsa_setup(): Sample format not available for playback: Invalid argument
>  
> thanks...

Well, duh, I forgot to attach the patch.

Here it is.

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

--- ice1712/ice1724.c~	2005-10-17 21:54:28.000000000 +0300
+++ ice1712/ice1724.c	2005-10-17 21:54:28.000000000 +0300
@@ -56,6 +56,7 @@ MODULE_DESCRIPTION("VIA ICEnsemble ICE17
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{"
 	       REVO_DEVICE_DESC
+	       REVO51_DEVICE_DESC
 	       AMP_AUDIO2000_DEVICE_DESC
 	       AUREON_DEVICE_DESC
 	       VT1720_MOBO_DEVICE_DESC
--- ice1712/revo.c~	2005-10-17 21:54:25.000000000 +0300
+++ ice1712/revo.c	2005-10-17 21:54:25.000000000 +0300
@@ -150,6 +150,10 @@ static int __devinit revo_init(ice1712_t
 		ice->num_total_dacs = 8;
 		ice->num_total_adcs = 2;
 		break;
+	case VT1724_SUBDEVICE_REVOLUTION51:
+		ice->num_total_dacs = 6;
+		ice->num_total_adcs = 2;
+		break;
 	default:
 		snd_BUG();
 		return -EINVAL;
@@ -164,6 +168,7 @@ static int __devinit revo_init(ice1712_t
 	ice->akm_codecs = 2;
 	switch (ice->eeprom.subvendor) {
 	case VT1724_SUBDEVICE_REVOLUTION71:
+	case VT1724_SUBDEVICE_REVOLUTION51:
 		if ((err = snd_ice1712_akm4xxx_init(ak, &akm_revo_front, &akm_revo_front_priv, ice)) < 0)
 			return err;
 		if ((err = snd_ice1712_akm4xxx_init(ak + 1, &akm_revo_surround, &akm_revo_surround_priv, ice)) < 0)
@@ -185,6 +190,7 @@ static int __devinit revo_add_controls(i
 
 	switch (ice->eeprom.subvendor) {
 	case VT1724_SUBDEVICE_REVOLUTION71:
+	case VT1724_SUBDEVICE_REVOLUTION51:
 		err = snd_ice1712_akm4xxx_build_controls(ice);
 		if (err < 0)
 			return err;
--- ice1712/revo.h~	2005-10-17 21:51:01.000000000 +0300
+++ ice1712/revo.h	2005-10-17 21:51:01.000000000 +0300
@@ -26,8 +26,11 @@
 
 #define REVO_DEVICE_DESC \
 		"{MidiMan M Audio,Revolution 7.1},"
+#define REVO51_DEVICE_DESC \
+		"{MidiMan M Audio,Revolution 5.1},"
 
 #define VT1724_SUBDEVICE_REVOLUTION71	0x12143036
+#define VT1724_SUBDEVICE_REVOLUTION51	0x12143136
 
 /* entry point */
 extern struct snd_ice1712_card_info snd_vt1724_revo_cards[];

--jI8keyz6grp/JLjh--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
