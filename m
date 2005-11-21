From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Terratec DMX6fire control signal
Date: Mon, 21 Nov 2005 22:55:56 +0000
Message-ID: <200511212255.56749.gineera@aspect135.co.uk>
References: <200511211515.38896.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200511211515.38896.gineera@aspect135.co.uk>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tiwai@suse.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Monday 21 November 2005 15:15, I wrote:
> I have been working on some patches for the Terratec DMX6fire.  The control
> signal 'Front Digital Input Switch' in alsamixer acts in reverse.  Is it
> better to rename it the opposite logic (which in this case might be
> 'Internal Digital Input Switch') or reverse its action in the route that
> the control connects to the hardware?

....Or the invert parameter could be set when the control is created, I just 
noticed?  It seems to do the job.

 Alan



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
