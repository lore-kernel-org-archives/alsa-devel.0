From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] emu10k1 multichannel support
Date: Fri, 11 Feb 2005 14:41:30 -0500
Message-ID: <1108150890.20365.7.camel@krustophenia.net>
References: <1106091073.24484.60.camel@krustophenia.net>
	 <1106672990.27843.7.camel@radium.gaugetheory.org>
	 <1106678585.10845.8.camel@krustophenia.net>
	 <1108148365.4267.22.camel@radium.gaugetheory.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <1108148365.4267.22.camel@radium.gaugetheory.org>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Brian L Scipioni <brian@gaugetheory.org>
Cc: alsa_users <alsa-user@lists.sourceforge.net>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-02-11 at 13:59 -0500, Brian L Scipioni wrote:
> Lee,
> 	Sorry for the re-post - maybe you 
> missed it?
> 	Prior to this patch, the IEC958 Optical slider controlled the volume
> out of the IEC958 Optical connection (given that IEC958 Optical Raw is
> muted).  Now this slider does nothing.  Full volume always present -
> mute switch still works though.
> 
> 	Is this a bug or a feature?  This is a change in behavior isn't it?

This was not intended.  Are you sure the multichannel patch introduced
this behavior?  Can you verify that the problem is not present with
current ALSA CVS?

Do you have an SBLive or Audigy?

Can someone else confirm the bug?

It will be hard for me to reproduce this as I don't have any IEC958
hardware, but we should be able to track it down via binary search.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
