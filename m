From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: workqueue lockup due to process_unsol_events stuck in
 azx_rirb_get_response
Date: Mon, 30 Jan 2017 16:02:38 +0100
Message-ID: <ce970c05-5f23-9dbc-6d5b-2faa8c1d4044@suse.cz>
References: <855fe8a9-4167-e193-d3d1-45e9d39630b1@suse.cz>
 <s5ha8afmbpu.wl-tiwai@suse.de> <798b5572-f02b-e58d-9996-f3ecb4f15e1a@suse.cz>
 <s5hwpdjjcgn.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hwpdjjcgn.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 01/25/2017 06:06 PM, Takashi Iwai wrote:
> The code path is related with the runtime PM, so it's likely depending
> on the device state, e.g. long-time pause or such.  I don't think Win
> 10 plays a role, but who knows.
>
> In anyway, let me know if this helps.  Basically I can merge it even
> for now, as the fix shouldn't give a regression.  But of course it'd
> be better to have a test result :)

OK so unfortunately it now happened with the patch.
