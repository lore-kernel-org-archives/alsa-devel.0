From: Magnus Sandin <magnus@sandin.cx>
Subject: [PATCH] Asus P5P800-VM, S/PDIF indication wrong?
Date: Mon, 21 Aug 2006 22:11:29 +0200
Message-ID: <44EA1371.7080009@sandin.cx>
References: <44E6BF9D.1090903@sandin.cx> <s5hirkozuwk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060202030401010609090401"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hirkozuwk.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060202030401010609090401
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello!

The attached patch will force building the S/PDIF controls on the PCU
SSID for Asus P5P800-VM motherboard, even if the  AC97_EI_SPDIF bit is
not set.

Is this approach OK or do you guys want to have the check somewhere else?

Signed-off-by: Magnus Sandin (magnus@sandin.cx)


Takashi Iwai wrote:
> At Sat, 19 Aug 2006 09:37:01 +0200,
> Magnus Sandin wrote:
>   
>> Hello!
>>
>> On my ASUS P5P800-VM motherboard, the onboard AC97-chip (Realtek ALC655)
>> does not indicate that there are any S/PDIF functionality available.
>>
>> However, the manufacturer (Asus) claim that there are S/PDIF output on
>> the board, and of course there is.
>>
>> I created a patch that check the PCI subsystem vendor id and device id,
>> and if it's a match to this board it ignores the AC97_EI_SPDIF bit when
>> the controls are built.
>> This allows me to get the desired S/PDIF output to work just as expected.
>>
>> I'm not sure this is good practise to just ignore this bit or force the
>> bit to 1?
>>
>> I have checked the BIOS for settings regarding S/PDIF, but there are
>> none. The only audio setting available is to control if the chip shall
>> be enabled or disabled.
>>     
>
> Well, I'd call it a BIOS bug.  But such a thing can always happen, of
> course...
>
>   
>> What do you recommend in this case?
>>     
>
> I think your approach is OK.  The only concern is that the board with
> the same PCI SSID might have a codec without SPDIF, but I guess the
> probability of this regression is quite low.
>
> So, just send a patch for merging (maybe after 1.0.12 release).
>
>
> Thanks,
>
> Takashi
>   

--------------060202030401010609090401
Content-Type: text/x-patch;
 name="asus_p5p800-vm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="asus_p5p800-vm.patch"

diff -Nru alsa-kernel/pci/ac97/ac97_codec.c alsa-kernel-patched/pci/ac97/ac97_codec.c
--- alsa-kernel/pci/ac97/ac97_codec.c	2006-08-18 20:11:26.000000000 +0200
+++ alsa-kernel-patched/pci/ac97/ac97_codec.c	2006-08-18 22:01:14.000000000 +0200
@@ -1533,7 +1533,9 @@
 	}
 
 	/* build S/PDIF controls */
-	if ((ac97->ext_id & AC97_EI_SPDIF) && !(ac97->scaps & AC97_SCAP_NO_SPDIF)) {
+	/* 0x1043, 0x810f ASUS P5P800-VM, which does not indicate S/PDIF capability */
+	if (((ac97->subsystem_vendor == 0x1043 && ac97->subsystem_device == 0x810f) || (ac97->ext_id & AC97_EI_SPDIF))
+		       	&& !(ac97->scaps & AC97_SCAP_NO_SPDIF)) {
 		if (ac97->build_ops->build_spdif) {
 			if ((err = ac97->build_ops->build_spdif(ac97)) < 0)
 				return err;

--------------060202030401010609090401
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--------------060202030401010609090401
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------060202030401010609090401--
