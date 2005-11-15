From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Multi ice1712 .asoundrc problem
Date: Tue, 15 Nov 2005 14:18:47 -0500
Message-ID: <1132082328.27215.35.camel@mindpipe>
References: <E1EbIYV-00019A-4u@localhost.localdomain>
	 <20051113223105.GA4822@localhost.localdomain>
	 <1131923292.27215.1.camel@mindpipe>
	 <20051114003718.GA5041@localhost.localdomain>
	 <1131960635.27215.16.camel@mindpipe>
	 <20051114121701.GA4044@localhost.localdomain>
	 <20051114155513.GO10146@edu.joroinen.fi>
	 <20051114190647.GA4797@localhost.localdomain>
	 <20051115151652.GA4404@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20051115151652.GA4404@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: John Rigg <ad@sound-man.co.uk>
Cc: Pasi =?ISO-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2005-11-15 at 15:16 +0000, John Rigg wrote:
> (unlike jackd, eg. `jackd -d alsa -d -C -i12 -P -o10 hw:0').

I think your jackd syntax is wrong.  The -P and -C arguments are
supposed to be immediately followed by the capture/playback device.
Like:

jackd -d alsa -C hw:0,2 -P hw:0,3 -i12 -o10

Lee



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
