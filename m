From: Alexandr <spiro@demiart.ru>
Subject: Re: About my Live! 5.1
Date: Sat, 26 Nov 2005 08:33:30 +0200
Message-ID: <438801BA.4050504@demiart.ru>
References: <43875FC3.9040408@demiart.ru> <1132950843.20390.62.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------030108040705050902020009"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1132950843.20390.62.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030108040705050902020009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Lee Revell wrote:

>On Fri, 2005-11-25 at 21:02 +0200, Alexandr wrote:
>  
>
>>Hi, Lee !
>>
>>
>>Model is "sb0220" correctly
>>
>>
>>    
>>
>
>OK try this patch.
>
>--- /home/rlrevell/cvs/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c~	2005-11-05 16:25:13.000000000 -0500
>+++ /home/rlrevell/cvs/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c	2005-11-25 15:28:47.000000000 -0500
>@@ -752,9 +752,16 @@
> 	 .emu10k1_chip = 1,
> 	 .ac97_chip = 1,
> 	 .sblive51 = 1} ,
>+	/* Tested by Alexandr 25th Nov 2005 */
>+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80661102,
>+	 .driver = "EMU10K1", .name = "SB Live 5.1 [SB0220]", 
>+	 .id = "Live",
>+	 .emu10k1_chip = 1,
>+	 .ac97_chip = 1,
>+	 .sblive51 = 1} ,
> 	/* Tested by Thomas Zehetbauer 27th Aug 2005 */
> 	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80651102,
>-	 .driver = "EMU10K1", .name = "SB Live 5.1 [SB0220]", 
>+	 .driver = "EMU10K1", .name = "SB Live 5.1 [SB0222]", 
> 	 .id = "Live",
> 	 .emu10k1_chip = 1,
> 	 .ac97_chip = 1,
>
>  
>
Ok. Right now it detect correctly:

bash-3.00# cat /proc/asound/cards
0 [Live           ]: EMU10K1 - SB Live 5.1 [SB0220]
                     SB Live 5.1 [SB0220] (rev.10, serial:0x80661102) at 
0xd000, irq 5

Tnx !

 But still problem with alsamixer:

bash-3.00# alsamixer
ALSA lib simple_none.c:1216:(simple_add1) helem (MIXER,'Front Playback 
Volume',0,0,0) appears twice or more

alsamixer: function snd_mixer_load failed: Invalid argument


--------------030108040705050902020009
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Lee Revell wrote:
<blockquote cite="mid1132950843.20390.62.camel@mindpipe" type="cite">
  <pre wrap="">On Fri, 2005-11-25 at 21:02 +0200, Alexandr wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Hi, Lee !


Model is "sb0220" correctly


    </pre>
  </blockquote>
  <pre wrap=""><!---->
OK try this patch.

--- /home/rlrevell/cvs/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c~	2005-11-05 16:25:13.000000000 -0500
+++ /home/rlrevell/cvs/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c	2005-11-25 15:28:47.000000000 -0500
@@ -752,9 +752,16 @@
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1,
 	 .sblive51 = 1} ,
+	/* Tested by Alexandr 25th Nov 2005 */
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80661102,
+	 .driver = "EMU10K1", .name = "SB Live 5.1 [SB0220]", 
+	 .id = "Live",
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
 	/* Tested by Thomas Zehetbauer 27th Aug 2005 */
 	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80651102,
-	 .driver = "EMU10K1", .name = "SB Live 5.1 [SB0220]", 
+	 .driver = "EMU10K1", .name = "SB Live 5.1 [SB0222]", 
 	 .id = "Live",
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1,

  </pre>
</blockquote>
Ok. Right now it detect correctly:<br>
<br>
bash-3.00# cat /proc/asound/cards<br>
0 [Live&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ]: EMU10K1 - SB Live 5.1 [SB0220]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SB Live 5.1 [SB0220] (rev.10, serial:0x80661102)
at 0xd000, irq 5<br>
<br>
Tnx !<br>
<br>
&nbsp;But still problem with alsamixer:<br>
<br>
bash-3.00# alsamixer<br>
ALSA lib simple_none.c:1216:(simple_add1) helem (MIXER,'Front Playback
Volume',0,0,0) appears twice or more<br>
<br>
alsamixer: function snd_mixer_load failed: Invalid argument<br>
<br>
</body>
</html>

--------------030108040705050902020009--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
