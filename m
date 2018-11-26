From: Jonathan Reeve <jon.reeve@gmail.com>
Subject: Subwoofers aren't working on ALC298 (Lenovo Yoga C930
	Laptop)
Date: Mon, 26 Nov 2018 10:40:36 -0500
Message-ID: <871s77zw23.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by alsa0.perex.cz (Postfix) with ESMTP id A5B7426751A
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2018 16:40:41 +0100 (CET)
Received: by mail-qt1-f177.google.com with SMTP id r14so18003640qtp.1
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2018 07:40:41 -0800 (PST)
Received: from jon-laptop (cpe-158-222-128-211.nyc.res.rr.com.
 [158.222.128.211])
 by smtp.gmail.com with ESMTPSA id n26sm283488qkg.74.2018.11.26.07.40.39
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 26 Nov 2018 07:40:39 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Alsa Devs,

I've been struggling with a sound issue for a while now. I just 
bought a new laptop that's known for its high-quality audio. It's 
billed as a Dolby Atmos speaker system, and it appears to be using 
a ALC298 card (or so I gathered from `aplay -l`). From what I can 
tell, it has tweeters in the back, and subwoofers on the bottom of 
the laptop. It sounds really great in Windows, but tinny and flat 
in Linux. I'm guessing this is because the subwoofers aren't being 
engaged.

Here are some things I've tried so far:

 - Tweaking what is possible to tweak in GNOME.
 - Running pavucontrol. No useful options here.
 - Unmuting everything in alsamixer. Unmuting only some things in 
 alsamixer.
 - Running hdajackretask, from the alsaTools package. It seems to 
 correctly recognize that there are some unassigned pins, and even 
 gives me the option of assigning them to "internal speaker 
 (LFE)," which sounds like it could be a bass output. But when I 
 click "apply now" or "apply boot options," the scripts fail by 
 saying they can't find tools like md or tee. I can run the 
 scripts it generates manually, but then the changes don't really 
 seem to take effect.
 - Following the instructions from the ALSA page on the wiki, and 
 trying all kinds of different options
 - All of the above, and also restarting alsa / snd_hda / 
 pulseaudio all manually.

As far as I can tell, I'm running the latest version of ALSA, 
since I'm on NixOS unstable, and 
[[https://github.com/NixOS/nixpkgs/blob/master/pkgs/os-specific/linux/alsa-firmware/default.nix][their 
build script]] seems to grab the latest version. 

[[http://www.alsa-project.org/db/?f=8c072b3fbb139d350cd0e2c4c98cbb7736c6455a][Here's 
the output from my alsa-info.sh.]] I don't know enough about ALSA, 
or sound hardware, to know what's going on there. Is it obvious 
from my alsa-info which pins I should try reassigning to which 
channels? And does anyone know of a good way of doing this? 
Preferably one that doesn't use hdajackretask, which doesn't 
appear to work on NixOS. 

[[https://unix.stackexchange.com/questions/482885/how-can-i-get-my-laptops-internal-speakers-to-work-correctly-on-nixos?noredirect=1#comment886606_482885][I 
also posted a few more details about this on this StackExchange 
question.]]

I hope that getting this to work will not only help me, but others 
with this same laptop or speaker configuration.

Thanks in advance for any help you'd be able to provide!

Best,

Jonathan
