From: Brian Victor <bhv1@psu.edu>
Subject: Re: General Guidelines?  (MIDI)
Date: Thu, 16 Jan 2003 17:37:35 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030116223735.GB32330@bhv1.adelphia.net>
References: <E18ZGLH-0005nh-00@sc8-sf-list2.sourceforge.net> <200301162227.36021.plcl@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200301162227.36021.plcl@telefonica.net>
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

On Thu, Jan 16, 2003 at 10:27:35PM +0100, Pedro Lopez-Cabanillas wrote:
>In short: start the queue before sending events, add snd_seq_drain_output at 
>end of SetTempo method.

...and then there was light!  Er.. sound!

Now that it's working, I'm left again with conceptual questions.  I was
under the impression that I could put events in a queue, start it, stop
it, and start it from the beginning again.  Is that not the case?  The
events seem to leave the queue once sent.

Likewise, I was under the impression that queues handled sequencing
events by timestamp if they arrived in non-sequential order.  Is that
so?  Do I just need to stay ahead of the queue for this to work?  Does
that mean, I can't reliably send the queue all events for one voice,
followed by all events for another voice?

Thank you, Pedro, for showing me how to fix my code.  That was a huge
help.

-- 
Brian


-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com
Understand how to protect your customers personal information by implementing
SSL on your Apache Web Server. Click here to get our FREE Thawte Apache 
Guide: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0029en
