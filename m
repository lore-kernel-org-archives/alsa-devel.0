From: Lee Revell <rlrevell-2FmhHzymoG5BDgjK7y7TUQ@public.gmane.org>
Subject: Re: Alsa problems with nforce2 (Solved)
Date: Wed, 22 Sep 2004 11:21:38 -0400
Sender: linux-audio-user-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
Message-ID: <1095866497.498.33.camel@krustophenia.net>
References: <1095791259.1175.15.camel@tag>
	<4150A00F.7090800@blackapache.net> <1095792330.5730.20.camel@tag>
	<1095793017.1176.1.camel@tag> <1095801409.1177.3.camel@tag>
	<Pine.LNX.4.58.0409220915061.20254@iua-mail.upf.es>
Reply-To: A list for linux audio users <linux-audio-user-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-audio-user-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0409220915061.20254-YsKO3VpTU6pu49Tpnmdm6g@public.gmane.org>
List-Unsubscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-user>,
	<mailto:linux-audio-user-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=unsubscribe>
List-Archive: <http://music.columbia.edu/pipermail/linux-audio-user>
List-Post: <mailto:linux-audio-user-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
List-Help: <mailto:linux-audio-user-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=help>
List-Subscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-user>,
	<mailto:linux-audio-user-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=subscribe>
Errors-To: linux-audio-user-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
To: A list for linux audio users <linux-audio-user-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
Cc: alsa-devel <alsa-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 2004-09-22 at 05:23, Maarten De Boer wrote:
> > I edit /etc/discover.conf and put disable the modules of OSS and
> > Voila!!!!
> 
> Remember those words... We will probably see this problem a lot in
> the future.
> 
> To resume: discover loads the OSS drivers when "discovering" the
> sound devices. Obviously, if a user installs alsa, the logical
> thing would be to blacklist the OSS drivers in the /etc/discover.conf
> automatically. But the problem is that, Debian policy, the alsa package
> is not allowed to change the configuration of another package. So the
> user has to add the blacklist to /etc/discover.conf himself.
> 
> As for as I understand, the solution would be to change discover
> configuration from a single file to a directory, where alsa can add
> it's blacklist during installation. A similar mechanism is already
> being used with hotplug)
> 

This is a good idea.  I am copying this to alsa-devel.

I suggested doing this in the ALSA drivers, having them printk() if
someone tries to load them with the OSS driver already loaded, but it's
much better to do it in userspace with a blacklist.

Lee
