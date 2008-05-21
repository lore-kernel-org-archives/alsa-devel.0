From: Charles Eidsness <charles.eidsness@ieee.org>
Subject: Re: External Plugin Non-Interleaved
Date: Wed, 21 May 2008 08:12:41 -0400
Message-ID: <483411B9.5040204@ieee.org>
References: <4833276F.6030502@ieee.org> <s5htzgsvtbh.wl%tiwai@suse.de>
Reply-To: charles.eidsness@ieee.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp109.rog.mail.re2.yahoo.com (smtp109.rog.mail.re2.yahoo.com
	[68.142.225.207]) by alsa0.perex.cz (Postfix) with SMTP id 820C22451E
	for <alsa-devel@alsa-project.org>;
	Wed, 21 May 2008 14:12:58 +0200 (CEST)
In-Reply-To: <s5htzgsvtbh.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> At Tue, 20 May 2008 15:33:03 -0400,
> Charles Eidsness wrote:
>> I'm working on a small ALSA pcm/ctl plugin to add support for LADSPA modules 
>> that include real-time controls (unless I'm missing something it looks like the 
>> native ALSA LADSPA module doesn't include real-time adjustable controls). I want 
>> to use it as a system wide equalizer. I'm using snd_pcm_extplug, I want to force 
>> access to be non-interleaved only but I can't figure out how. Is there some way 
>> to force non-interleaved access for an extplug?

Takashi Iwai wrote:
> No, extplug itself cannot restrict the access format, so far.
> It's possible to add a new restriction to extplug, though...
> 
> 
> Takashi
> 

It would be a nice feature to have. I noticed that ioplug has that restriction, 
could
the restriction code some ioplug just be pulled into extplug?

Charles
