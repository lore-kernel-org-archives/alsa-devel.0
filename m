From: Stephen Hassard <steve@hassard.net>
Subject: Re: Audigy 2 support - update
Date: Sat, 24 May 2003 09:49:45 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030524164945.GA17884@www.angiotech.com>
References: <20030523051240.GA10831@www.angiotech.com> <1053747883.6906.10.camel@rivendell.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1053747883.6906.10.camel@rivendell.home.local>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, May 23, 2003 at 08:44:43PM -0700, Florin Andrei wrote:
> Stephen, do you mind sharing with us the ALSA-relevant part of your
> /etc/modules.conf file, please?

I'm particularly lazy about using modules.conf, so I generally don't bother using it.

I tend to load everything via /etc/modules (debian module auto-loading) in the order that I want the devices to be.

Here's what my /etc/modules looks like:
>>
snd-emu10k1
snd-emu10k1-synth
snd-emux-synth
snd-mixer-oss
snd-pcm-oss
snd-seq-oss
<<

> Also, what's the distribution you're using, and what's the exact kernel
> version?

I'm using debian unstable with a custom kernel. I'm using kernel 2.4.20 w/ the ck patch over at http://members.optusnet.com.au/ckolivas/kernel/ for reduced latency (it make a big difference to the performance of my box). I compiled everything with gcc-2.95.4.

later,
Steve


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
