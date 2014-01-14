From: Daniel Mack <daniel@zonque.org>
Subject: Re: Tenor TE8802,
 USB : clics and crackles during music play
Date: Tue, 14 Jan 2014 15:34:17 +0100
Message-ID: <20140114143417.GB23764@tamtam.fritz.box>
References: <CA+T9nP_hcPQBoQwike7oB5TfECax2MvARv0dTG9qB-RdFMuy=w@mail.gmail.com>
 <CA+T9nP-=ffsy9ftnxynUhdJK_Eev+S-MRznLz7CED-Yp3DiOjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CDB52616FF
 for <alsa-devel@alsa-project.org>; Tue, 14 Jan 2014 15:34:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CA+T9nP-=ffsy9ftnxynUhdJK_Eev+S-MRznLz7CED-Yp3DiOjg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eric F <3rik.gm@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Jan 12, 2014 at 04:43:06PM +0100, Eric F wrote:
> Been searching for days on Internet for this issue, without luck :(
> 
> I own a Teac UD-H01 : when connected via USB => crackles and clicks

Which tool are you using in userspace to test this? Did you try aplay?

> optical => no problem

I'm confused. According to

  http://www.teac.com/product/ud-h01/

there is no optical output. Are you saying things only work if you
connect an optical input?

Are you absolutely sure that you're not dealing with analog audio
distortion? IOW: did you try the very same setup with a different OS?

> I want to use it as USB because it's asynchronous, so only a few jitter

I don't follow. According to the device specs, USB is the only option to
connect this thing?

> I've tried many kernels (3.12.7, 3.12.6) and the LTS that I use normally
> (3.10.25, 3.10.26) : not solved
> 
> I've tried on a fresh ArchLinux install : no way
> I've tried Xubuntu : not better (plus they use pulseaudio)
> I've tried on my desktop's Arch Linux
> 
> I'd like to know if any of you have a patch or a fix for the Tead UD-H01
> DAC when used via USB

The device exposes itself as USB audio v2 interface, so it should work
out-of-the-box. What's interesting is that there are two clock sources,
but only one is connected in the topology (bCSourceID = 12), and there
is no clock selector. Crackles could be related to wrong clocking, but
that's just guessing.

Please check whether the device works under Windows or Mac OS X.


Daniel
