From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Exemple of source code for capture without using
 callback
Date: Thu, 22 Oct 2009 17:06:03 +0200
Message-ID: <4AE074DB.4030600@ladisch.de>
References: <26289049-EACA-4DC6-A396-E2AF4EB6F2E9@gmail.com>
	<ad2655cb0910220740k5ef0f931j7f0ec48cb5d01cec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 41DAC24405
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Oct 2009 17:06:08 +0200 (CEST)
In-Reply-To: <ad2655cb0910220740k5ef0f931j7f0ec48cb5d01cec@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <james.dutton@gmail.com>
Cc: alsa-devel@alsa-project.org, brunal2496 gmail <brunal2496@gmail.com>
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:
> 2009/10/20 brunal2496 gmail <brunal2496@gmail.com>:
> > I've read everywhere that using callback is a bad method to use the
> > alsa drivers.
> 
> This is wrong. callback is the best method.

But _not_ the snd_async_add_pcm_handler function, which is evil.
(This is the only ALSA PCM function that mentions "callback" in its
documentation, so these are often confused.)

The 'good' callback method means that the audio driver informs the
application when its wants to have new audio data, not the other way.


Best regards,
Clemens
