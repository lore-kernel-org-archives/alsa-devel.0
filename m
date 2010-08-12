From: Dave Zielinski <DZielinski@righthandtech.com>
Subject: Re: Pops, Clicks on Capture w/ S/PDIF,
 Cirrus Logic CS4207, HDA
Date: Thu, 12 Aug 2010 12:42:31 -0500
Message-ID: <69FA8BA3444DD443841AF768F2F6C65A1249021427@SERVER2.righthandtech.local>
References: <69FA8BA3444DD443841AF768F2F6C65A12490213C9@SERVER2.righthandtech.local>
	<4C639AAB.5050606@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from remote.righthandtech.com
	(173-161-64-18-Illinois.hfc.comcastbusiness.net [173.161.64.18])
	by alsa0.perex.cz (Postfix) with ESMTP id AE261243A4
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Aug 2010 19:42:29 +0200 (CEST)
In-Reply-To: <4C639AAB.5050606@ladisch.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Clemens,
   Yes prior location is exactly 1 buffer_size! - which is this case was 16384.  But what does that mean? 

Also, I tried inserting 'coef |= 0x0040' and ran a 'arecord | aplay' and it sounded like white-noise.  Although I am using a Sine wave generator to troubleshoot this and it sounded like changing the frequency audibly affect it a little, so it's not pure noise.  But anyway it sounds like this is a different problem.  I would not expect this to be a freq conversion problem as I'm putting in 48kHz and reading as 48kHz.   Also I can put in 44.1kHz and read out 48kHz and everything seems to work the same.  

Do you have any other ideas for things the check?  In the meantime will be studying the code in the meantime to try and get my arms around how buffers are getting transferred from the hardware to kernel-space and kernel-space to user-land.  I currently don't understand this.

Thanks for your response,
Dave Z.


-----Original Message-----
From: Clemens Ladisch [mailto:clemens@ladisch.de] 
Sent: Thursday, August 12, 2010 1:55 AM
To: Dave Zielinski
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Pops, Clicks on Capture w/ S/PDIF, Cirrus Logic CS4207, HDA

Dave Zielinski wrote:
> ...
> So now we're getting some audio but it comes with pops and clicks when
> we try to capture.  An analysis of the captured stream shows there are
> corruptions of the data that are 8192 frames apart which I believe are
> the 4096 frame period boundaries (although tough to know for sure).
> When the corruption occurs there seems to be 5 to 7 frames that are
> screwed up.   Also worth noting: these same exact samples appear in
> the stream at a prior location so I think its old buffer data.

How far away is that prior location; exactly buffer_size?

If not, this looks like a bug in the CS4207's RX sample rate converter.
Try disabling it by setting bit 6 in the S/PDIF interface control
register (insert "coef |= 0x0040;" in the init_digital function).


Regards,
Clemens
