From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [sdr-widget] UAC2 sampling freq setting
Date: Fri, 11 Jun 2010 09:02:11 +0200
Message-ID: <20100611070211.GT17833@buzzloop.caiaq.de>
References: <a3ec17f9-b3a9-42f1-86b9-081b6f234faa@6g2000prg.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 943191039A6
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Jun 2010 09:02:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <a3ec17f9-b3a9-42f1-86b9-081b6f234faa@6g2000prg.googlegroups.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alex Lee <alexlee188@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

(Moving this discussion from sdr-widget to alsa-devel. Can't Cc: the
 original mailing list as it forbids cross-posting)

On Thu, Jun 10, 2010 at 09:36:48PM -0700, Alex Lee wrote:
> I studied the driver source again and it becomes apparent that the
> driver only looks at the MIN value of the triplet (MIN, MAX, RES).  It
> does not take into consideration of the MAX and the RES in each
> triplet.

For samplerates it does that, yes.

> The driver calculates its own MIN and MAX values by going through all
> the triplets in the clock source.  In the present firmware, we only
> have ONE triplet in each clock source, with:
> 
> # of triplets = 1 (2 byte value)
> MIN  48000
> MAX 96000
> RES 48000

Ah, that's a corner case I didn't see. I'll fix this.

> in accordance with the UAC2 specs.  The present driver code expects:
> 
> # of triplets = 2  (2 byte value)
> triplet 1:
> 
> MIN  48000   MAX 48000 RES 00000
> 
> triplet 2:
> 
> MIN 96000 MAX 96000 RES 00000

Yes, that's right. All firmware code I've seen so far also has a triplet
for each discrete sample rate.

> Thus the present driver cannot decode the 1st case above correctly,
> and only get the 48khz value.
> 
> I will update the firmware to cater to the 2nd case above and we
> should have the 96khz back :-)

Ok, fair fix. I'll make sure future versions of the driver also support
the other approach.

Thanks,
Daniel
