From: Ben Dooks <ben-alsa@fluff.org>
Subject: Re: AIC23 on i2C
Date: Wed, 11 May 2005 23:59:01 +0100
Message-ID: <20050511225901.GQ20090@trinity.fluff.org>
References: <a0580c510505111145101242a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <a0580c510505111145101242a0@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Eduardo Bezerra <edubezval@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, May 11, 2005 at 02:45:09PM -0400, Eduardo Bezerra wrote:
> Hi folks,
> 
> 
> 
>  I need to know if there is any driver to AIC23 on I2C written on ALSA.
> 
> If there isn't, I want to know how can I get documentation to do this
> task, because
> the how-to that I found on 
> http://www.alsa-project.org/~iwai/writing-an-alsa-driver/index.html
> 
> shows only how to write a pci driver.

I've got a tlv320aic23 driver done with the s3c2410 audio system
(see patches submitted to the list a while ago). The only problem
is there is no standard interface for the attaching of IIS based
codecs to ALSA drivers, unlike AC97.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
