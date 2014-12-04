From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Nodes, Widgets,
	ELD and Digital Surround 5.1 (HDMI) Output?
Date: Thu, 4 Dec 2014 20:08:23 +0800
Message-ID: <CAN8cciZSkyh5V7_dppmzt5Fs-8nJCpkcGD4zurqn94=XJymZ6A@mail.gmail.com>
References: <499A51023C98481A9A8BE9EBEFDDFD70@Lyra>
 <547EBCFF.5030204@canonical.com> <547EC2BF.3080601@gmail.com>
 <46543BFB759444F4B56F5153F4727DEE@Lyra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f43.google.com (mail-qa0-f43.google.com
 [209.85.216.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 9963C260538
 for <alsa-devel@alsa-project.org>; Thu,  4 Dec 2014 13:08:24 +0100 (CET)
Received: by mail-qa0-f43.google.com with SMTP id bm13so11625012qab.2
 for <alsa-devel@alsa-project.org>; Thu, 04 Dec 2014 04:08:23 -0800 (PST)
In-Reply-To: <46543BFB759444F4B56F5153F4727DEE@Lyra>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bencoxdev@gmail.com
Cc: ALSA Mailing list <alsa-devel@alsa-project.org>, "Alexander E. Patrakov" <patrakov@gmail.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

> Hi Guys,
>     Thank you for your input it's much appreciated.
>
>     I have now produced the pulse audio log as suggested and it appears
that
> when an attempt to open the Digital Surround 5.1 device, it fails with a
> "No such file or directory" error. Here is a snippet of the log showing
the
> error.
>
> (   0.456|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:iec958-ac3-surround-51
> (   0.456|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback
on Digital Surround 5.1 (IEC958/AC3) (iec958-ac3-surround-51)
> (   0.456|   0.000) D: [pulseaudio] alsa-util.c: Trying a52:1 with
SND_PCM_NO_AUTO_FORMAT ...
> (   0.456|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM a52:1
> (   0.456|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device
a52:1: No such file or directory
>
> So I guess the next question is what is responsible for producing the
> required device?
>

http://git.alsa-project.org/?p=alsa-plugins.git;a=blob;f=doc/a52.txt;hb=HEAD

card number and channels are  hardcoded
