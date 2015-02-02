From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 03/14] ALSA: Add a helper to initialize
	device
Date: Mon, 02 Feb 2015 14:43:02 +0100
Message-ID: <54CF7EE6.6080601@metafoo.de>
References: <1422872678-4815-1-git-send-email-tiwai@suse.de>	<1422872678-4815-4-git-send-email-tiwai@suse.de>	<54CF7C3C.6020100@metafoo.de>
 <s5hh9v4fn4e.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-232.synserver.de (smtp-out-232.synserver.de
 [212.40.185.232])
 by alsa0.perex.cz (Postfix) with ESMTP id C293A2605AA
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 14:43:01 +0100 (CET)
In-Reply-To: <s5hh9v4fn4e.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/02/2015 02:40 PM, Takashi Iwai wrote:
[...]
>> And on the long run things
>> should probably be re-factored to do all memory freeing in a subdevice
>> specific release function.
>
> This patchset is one step toward the simplification, indeed.
>
> But, what do you have in mind when you write "a subsystem specific
> release function"?

"subdev specific". What you already do for e.g. hwdep and MIDI, but for all 
of the subdevice types, so the empty default function is no longer needed.

The kfree(container_of(...)) stuff.

- Lars
