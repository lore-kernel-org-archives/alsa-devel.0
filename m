From: "Eliot Blennerhassett" <bigblen@icqmail.com>
Subject: Re: ANN: AudioScience driver beta  0.3 (0.9.6)
Date: Thu, 18 Sep 2003 15:21:34 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030918152135.29823.h006.c012.wm@mail.icqmail.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tiwai@suse.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

<snip>
> the question is, again, whether we should include HPI driver code in
> the ALSA tree.  this means that the code would be changed often by us,
> ALSA developers, or by other people, too.  what do you think?

I have no objection to that happening.  We'll see after the code has been
reviewed whether it is the best thing to do.  The current patch code compiles OK
without the HPI driver installed.   It is only at driver load time that HPI
driver is needed.

Initially, I imagine that most people will have better things to do than to mess
with "our" code.  
It would be an advantage to us to have it supported by the nice configure and
build system.

I suppose there is a risk of code divergence between our internal codebase and
the version in ALSA tree, however I think there is good motivation on both sides
to keep in sync so that the ALSA version doesn't fall behind as we add new
features.  

For our purposes the HPI code gets built into various windows drivers as well as
the Linux HPI driver.  So for our purposes we have to keep all that working.
Particularly, Linux applications using the HPI API and ioctl interface must
continue to work alongside ALSA access.  (i.e. for multistream cards, one stream
and output can be used by ALSA for system sound etc, the rest by a dedicated HPI
application).

regards


Eliot Blennerhassett
AudioScience Inc.
--
Junk footer beyond this point. Read at your own risk.


-------------------------------------------------------------
Sign up for ICQmail at http://www.icq.com/icqmail/signup.html


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
