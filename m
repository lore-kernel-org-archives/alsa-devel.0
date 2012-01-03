From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: question application playback
Date: Tue, 03 Jan 2012 18:19:00 +0530
Message-ID: <1325594940.1540.53.camel@vkoul-udesk3>
References: <1325593416.22411.YahooMailNeo@web161301.mail.bf1.yahoo.com>
	<4F02F487.9080906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 4EFEE247A4
	for <alsa-devel@alsa-project.org>; Tue,  3 Jan 2012 13:48:49 +0100 (CET)
In-Reply-To: <4F02F487.9080906@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2012-01-03 at 13:28 +0100, Daniel Mack wrote:
> On 01/03/2012 01:23 PM, Ricardo Barbosa wrote:
> > I am new to development using the alsa API and follow the link code http://equalarea.com/paul/alsa-audio.html
> > 
> > insert the following code.
> > 
> >  FILE *fp;
> >  fp = fopen("file.mp3", "r");
> 
> MP3s are compressed audio files that cannot be used directly with the
> ALSA API. If you have to use mp3 files, have a look at libmpg123 or use
> a higher level interface in the first place, for example GStreamer.
Not true anymore, if you have device which supports compressed formats,
the shining new alsa compress API are there for you to use :)

See Documentation/sound/alsa/compress_offload.txt

-- 
~Vinod
