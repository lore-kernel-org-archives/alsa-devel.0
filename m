From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: vga kills the audio NO MORE !!!
Date: Sat, 14 May 2005 16:19:42 -0400
Message-ID: <1116101982.9141.35.camel@mindpipe>
References: <Pine.NEB.4.62.0505141920320.23428@droog.sdf-eu.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.NEB.4.62.0505141920320.23428@droog.sdf-eu.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Laurence Darby <ldarby@sdf-eu.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 2005-05-14 at 20:12 +0000, Laurence Darby wrote:
> 
> I have a PCI trident cyberblade graphics chip, and if almost anything 
> happened on screen, the audio would squeal and squawk.  I've fixed it for 
> this card.  The doc at http://www.alsa-project.org/misc/vgakills.txt 
> basically says to put the accelerator command queue status check back in 
> to the graphics driver, which is what I've done, with some guess work 
> too...
> 
> I think it slightly decreases performance, so the Xorg devs probably 
> wouldn't be interested, but as it increases audio quality, I guess this is 
> the place to post about it.  If there are other lists you think may be 
> interested, feel free to forward it on.

They should be interested.  Not checking the FIFO status before writing
to it is a bug.

The via driver had the same bug, which was fixed after I reported it to
the developers.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
