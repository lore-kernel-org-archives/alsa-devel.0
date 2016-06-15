Return-Path: <alsa-devel-bounces@alsa-project.org>
Date: Wed, 15 Jun 2016 09:11:53 +0200
From: Richard Cochran <richardcochran@gmail.com>
Message-ID: <20160615071153.GC2919@netboy>
References: <1465686096-22156-1-git-send-email-henrik@austad.us>
 <20160613114713.GA9544@localhost.localdomain>
 <20160613130059.GA20320@sisyphus.home.austad.us>
 <20160613193208.GA2441@netboy>
 <20160614093000.GB21689@sisyphus.home.austad.us>
 <20160614182615.GA2741@netboy>
 <20160614203810.GC21689@sisyphus.home.austad.us>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160614203810.GC21689@sisyphus.home.austad.us>
Subject: Re: [alsa-devel] [very-RFC 0/8] TSN driver for the kernel
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: alsa-devel@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>, linux-media@vger.kernel.org
List-ID: <alsa-devel@alsa-project.org>

On Tue, Jun 14, 2016 at 10:38:10PM +0200, Henrik Austad wrote:
> Where is your media-application in this?

Um, that *is* a media application.  It plays music on the sound card.

> You only loop the audio from 
> network to the dsp, is the media-application attached to the dsp-device?

Sorry, I thought the old OSS API would be familiar and easy to
understand.  The /dev/dsp is the sound card.

Thanks,
Richard
--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
