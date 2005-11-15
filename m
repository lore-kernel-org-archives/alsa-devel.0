From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Dmix and non SND_PCM_TYPE_HW slaves
Date: Tue, 15 Nov 2005 08:39:06 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0511150835390.9148@tm8103.perex-int.cz>
References: <OFB5C60420.D5C0FB76-ON652570BA.00273D48-652570BA.00273D59@flextronicssoftware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <OFB5C60420.D5C0FB76-ON652570BA.00273D48-652570BA.00273D59@flextronicssoftware.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: sameer.kittur@flextronicssoftware.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 15 Nov 2005 sameer.kittur@flextronicssoftware.com wrote:

> Hi all,
> 
>     Is there a reason why Dmix cannot use a non SND_PCM_TYPE_HW slave? Is
> there no way to re-direct the Dmix output to another plugin or an
> external I/O or a filter plugin?

It's impossible without massive changes to the dmix code and structure. 
Dmix uses too much driver specific things like the PCM timer, passing PCM 
device file-descriptor among applications etc. Also, the latency can be 
much worse when the dmix plugin will use only SHM ring buffer or so.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
