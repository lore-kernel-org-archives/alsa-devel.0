From: asbjs@stud.ntnu.no (Asbjørn Sæbø)
Subject: Re: emu10k1 sample rates?
Date: Mon, 18 Oct 2004 08:41:58 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041018064158.GA16396@stud.ntnu.no>
References: <200410131456.i9DEu8RQ013026@www6.pobox.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 13, 2004 at 04:56:08PM +0200, Peter Zubaj wrote:
> Hi,
> 
> AFAIK:


(kouhia@nic.funet.fi:) 
> >When I record from emu10k1 (e.g., from livedrive linein2)
> >with sample rate 44100 Hz, then what sample rate the
> >emu10k1 is running at?
> 
> 48000 Hz
> [...]

> >(2) Who does the conversion to 44100 Hz?
> 
> emu10k1 - whe it writes samples to buffers


Does this mean that the latency in the card will be higher when working 
at 44100 than when working at 48000?

Asbj.S.


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
