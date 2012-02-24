From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: HDA intel, wired headset w/mic, jack mic detect
Date: Fri, 24 Feb 2012 07:25:19 +0100
Message-ID: <4F472D4F.3000904@canonical.com>
References: <87ehtlwen3.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id CD4DD244C1
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 07:25:22 +0100 (CET)
In-Reply-To: <87ehtlwen3.fsf@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kevin Hilman <khilman@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/23/2012 08:09 PM, Kevin Hilman wrote:
> Hello,
>
> I'm trying to get a wired headset with a mic working on MacBookAir
> running v3.0 (3.0.0-13-generic from Ubuntu to be precise.)
>
> It has Intel HDA audio[1] and everything works fine, including the
> built-in mic.  The only think I can't seem to get working is a headset
> w/mic.
>
> I know the HW for dynamic detect works because the mic is detected
> dynamically under OSX.  Is there some setting I need to tweak in order
> to enable the automatic mic detection?
>
> Thanks for any pointers,

Hi Kevin,

You can try upgrading your alsa version to the daily snapshot using this 
method: https://wiki.ubuntu.com/Audio/UpgradingAlsa/DKMS


-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
