From: "Chris Pimlott" <pimlottc@gmail.com>
Subject: Re: No HDMI audio on Asus P5Q-EM
Date: Sun, 14 Dec 2008 12:17:54 -0500
Message-ID: <d5db635d0812140917u3f8ea1ccw7f0151e7cee024d@mail.gmail.com>
References: <d5db635d0812111241u4852cf75v707be56f192eec9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f20.google.com (mail-qy0-f20.google.com
	[209.85.221.20]) by alsa0.perex.cz (Postfix) with ESMTP id F06E82438F
	for <alsa-devel@alsa-project.org>; Sun, 14 Dec 2008 18:17:55 +0100 (CET)
Received: by qyk13 with SMTP id 13so2420170qyk.8
	for <alsa-devel@alsa-project.org>; Sun, 14 Dec 2008 09:17:54 -0800 (PST)
In-Reply-To: <d5db635d0812111241u4852cf75v707be56f192eec9@mail.gmail.com>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Forgot to join the list first, also here is the bugtrack issue:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4281

On Thu, Dec 11, 2008 at 3:41 PM, Chris Pimlott <pimlottc@gmail.com> wrote:

> I have an Asus P5Q-EM motherboard, with Intel G45 chipset and Realtek ALC
> 1200 integrated audio, with HDMI output. (Specifications:
> http://www.asus.com/products.aspx?modelmenu=2&model=2413&l1=3&l2=11&l3=761&l4=0)<http://www.asus.com/products.aspx?modelmenu=2&model=2413&l1=3&l2=11&l3=761&l4=0%29>[
> ^<http://www.asus.com/products.aspx?modelmenu=2&model=2413&l1=3&l2=11&l3=761&l4=0%29>
> ]
>
> The analog output has always worked fine (from the default Mythbuntu
> install), but I do not get any output when trying to use the HDMI. I am
> testing with aplay: "aplay -D plughw:0,3
> /usr/share/sounds/alsa/Front_Center.wav". plughw:0,1 with the same command
> works (on analog out).
>
> I see three devices, "IEC958", "IEC958 Default PCM" and "IEC958 1", which
> are all unmuted. I have tried flipped the copyright setting with "iecset -n
> 1 copy on" but that has made no difference.
>
> I have tried a number of versions, including the stock 2.6.27 kernel
> package shipped in Mythbuntu, alsa-1.0.18 and alsa-1.0.18a, as well as
> version of the sound-2.6 from 2008-11-23 and today. The most recent I'm
> trying is sound-2.6 version is b13a9d80db0f1f4ace2863e8824a3d3299730d0a.
>
> I've notice there's been a fair amount of updates to this area of the
> snd_hda_intel driver, and some changes to how the device has shown up in
> recent releases. Should I even expect this to work, or is it still
> "in-progress"?  Thanks.
>
> Chris Pimlott
>
