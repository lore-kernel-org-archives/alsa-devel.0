From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: CODEC plug in
Date: Thu, 12 May 2005 11:15:25 -0400
Message-ID: <1115910925.20909.23.camel@mindpipe>
References: <20050512145910.57874.qmail@web31702.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050512145910.57874.qmail@web31702.mail.mud.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: rong wang <rhong_wang@yahoo.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2005-05-12 at 07:59 -0700, rong wang wrote:
> I am new in linux. My question is where is the CODEC
> plug-in, I can plug in different codec of my own in
> the ALSA. Where is the digital mixing and sample rate
> conversion in the ALSA? 
> 

These live in userspace.  Mixing is handled by dmix, SRC by the plughw
plugin.  See the alsa-lib distribution.

> Is there any complete design doc for the ALSA? So, I
> can see the control flow top-down.

Not exactly.  But this document should give a pretty good idea of the
control flow when using a PCM.

http://www.alsa-project.org/~iwai/writing-an-alsa-driver/

Lee




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
