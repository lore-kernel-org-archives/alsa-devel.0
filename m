From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: emu10k1 sample rates?
Date: Wed, 13 Oct 2004 11:12:13 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1097680332.5879.9.camel@krustophenia.net>
References: <200410131456.i9DEu8RQ013026@www6.pobox.sk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200410131456.i9DEu8RQ013026@www6.pobox.sk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Zubaj <pzad@pobox.sk>
Cc: kouhia@nic.funet.fi, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2004-10-13 at 10:56, Peter Zubaj wrote:
> Audigy 2 is litle diffrent. There is another part which can run at 48,
> 96, 192 KHz, runs in paralel to emu10k2, but there is not DSP and this
> part is not supported under linux.
> 

This could in theory be supported, because this part that does 96/192 is
the P16V chip which is supported in the emu10k1x driver thanks to James
Courtier-Dutton.   I think the issue is just that no one has time to do
it.

Lee



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
