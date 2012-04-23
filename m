From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [snd-usb-audio] frequent "delay: estimated xxx,
 actual yyy" messages
Date: Mon, 23 Apr 2012 12:43:11 -0500
Message-ID: <4F9594AF.4090902@linux.intel.com>
References: <3172169.OcqrdKakkS@siegfried>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id D8AB724345
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Apr 2012 19:43:26 +0200 (CEST)
In-Reply-To: <3172169.OcqrdKakkS@siegfried>
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

On 4/21/2012 5:22 AM, Guillaume Clement wrote:
> Hello,
>
> I am using an USB soundcard (ID : 046d:0a24 : Logitech Speaker Lapdesk N550).
>
> During playback, I have frequent messages like these :
>
> delay: estimated 795, actual 662
> delay: estimated 133, actual 0
> delay: estimated 751, actual 662
> delay: estimated 89, actual 0
>
>
> When those messages appear, I am hearing some "cracks" from the soundcard.
>
>
> I've tried to make some research on this, I only found some messages that hint
> about some interrupt problems. I'm not using any closed source driver and I
> can reproduce the issue with any computer running Linux.
>
>
> On interesting thing to notice is that it happens only when the CPU is near
> idle. To workaround the problem, I can just do something like :
>
> nice -n 20 dd if=/dev/zero of=/dev/null bs=1k count=500G
>
>
> This would keep my CPU busy and I have no more messages nor cracks.
I'm the one who introduced this warning when I added support for a 
better delay estimate based on the frame counter instead of bytes 
submitted (back in September 2011). When writing new data the estimate 
using the frame counter and the byte count should be identical, but this 
message shows something goes wrong.
Somehow I don't understand how a more precise delay would cause such 
errors. The delay is only important for pulseaudio, it shouldn't affect 
plain vanilla alsa. You could try and reverse the patch to see if this 
improves anything? If not, you have another problem in your setup...
-Pierre
