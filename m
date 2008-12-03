From: Daniel Mack <daniel@caiaq.org>
Subject: Re: [PATCH] tlv320aic3x: headset/button press support
Date: Wed, 3 Dec 2008 11:39:48 +0100
Message-ID: <20081203103948.GA7657@buzzloop.caiaq.de>
References: <20081126220742.GA24648@buzzloop.caiaq.de>
	<20081127114951.GA3933@sirena.org.uk>
	<20081202163754.GA29550@buzzloop.caiaq.de>
	<20081202195013.GA6972@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 956B21037EB
	for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2008 11:39:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id 18B177F402D
	for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2008 11:39:51 +0100 (CET)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop.caiaq.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ptxDZHO4JdUZ for <alsa-devel@alsa-project.org>;
	Wed,  3 Dec 2008 11:39:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081202195013.GA6972@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Ben,

On Tue, Dec 02, 2008 at 07:50:19PM +0000, Mark Brown wrote:
> > There is different types of headsets supported by this chip (see page 42
> > of the datasheet), and this bits define which types the detection should
> > be enabled for.
> 
> I *belive* it's a headset but please submit a patch adding some text
> documenting this, ideally people shouldn't have to refer to the
> datasheet to use the driver.

Ok, added some lines of comment in my new version. However, I strongly
believe that anyone who uses that chip needs to read the datasheet
carefully anyway as it is very versatile and full of pitfalls therefore.

> As I have repeatedly mentioned it would be very much better if you were
> to do your submissions in the standard fashion which is documented in
> Documentation/SubmittingPatches.

I'm switching over to git-format-patch now, hoping this tool does it
right. Sorry for the trouble, I didn't want to bother you.

Best regards,
Daniel
