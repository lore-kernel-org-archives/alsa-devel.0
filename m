From: David Lloyd <dmlloyd@tds.net>
Subject: Re: Quake3 and DMIX
Date: Sat, 31 Jan 2004 11:14:50 -0600 (CST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401311106120.3888@ultros>
References: <Pine.LNX.4.58.0401082219001.32519@ultros>
 <Pine.LNX.4.58.0401311602310.1876@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0401311602310.1876@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA Mailing List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 31 Jan 2004, Jaroslav Kysela wrote:

> On Fri, 30 Jan 2004, David Lloyd wrote:
> 
> > This actually covers (I think) all games based on the Quake3 engine.
> > 
> > So far, my attempts to get these games to work with the alsa dmix plugin 
> > have met with failure.
> 
> Well quake uses oss mmap() feature which is tricky. We probably ommited
> something in our emulation or the support might be problematic.
> 
> Also, you may try to add 'slowptr yes' to your dmix plugin definition to
> see if it helps.

It did help, I can actually hear noise that resembles the Enemy Territory
game music somewhat... I think we're getting closer.

Here's some more information that might be helpful.  When I run the game 
using the normal kernel /dev/dsp oss emulation, it works fine.  I captured 
the contents of the /proc/asound/card0/pcm0p/sub0/*_params when running 
without aoss, here it is:

access: MMAP_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 22050 (22050/1)
period_size: 1024
buffer_size: 16384
tick_time: 1000
OSS format: S16_LE
OSS channels: 2
OSS rate: 22050
OSS period bytes: 4096
OSS periods: 16
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 1
xfer_align: 1
start_threshold: 1
stop_threshold: 1073741824
silence_threshold: 0
silence_size: 0
boundary: 1073741824

I thought I'd try putting the period_size and buffer_size in my .asoundrc 
to see what happens.  But when I do this, the game can't "open" /dev/dsp:

------- sound initialization -------
/dev/dsp: Invalid argument
Could not open /dev/dsp
------------------------------------

It seems to me there's a variety of things that could make oss_dsp_open 
return EINVAL or -EINVAL.  Any ideas what to check next?

- D


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
