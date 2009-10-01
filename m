From: Steve Chen <schen-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: RE: [alsa-devel] [PATCH 2/3] ASoC: DaVinci: pcm, rename variables
	in prep for ping/pong
Date: Thu, 1 Oct 2009 13:46:45 -0500
Message-ID: <1254422805.3153.26.camel@linux-1lbu>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DDAB3EB5@dbde02.ent.ti.com>
	<7A436F7769CA33409C6B44B358BFFF0C012A458365@dlee02.ent.ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DDB71445@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DDB71445-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 2009-10-01 at 23:43 +0530, Nori, Sekhar wrote:
> Hi Arun,
> 
> On Tue, Sep 29, 2009 at 20:51:49, Mani, Arun wrote:
> > Hi Sekhar,
> > DM355 uses MCBSP 1 instead of 0 as in DM644x. Do you think this will affect the channel
> > swapping?
> 
> I don't think this would have a bearing.
> 
> > Another thing is I was able to run aplay and arecord without Troy's patches, but seems
> > like gstreamer still fails with his patches.
> 
> I haven't tried gstreamer, but that's surprising. Can you post
> the error logs? Maybe someone familiar with gstreamer could comment.
> 
Arun,

Do you observe any errors when playing sound file through ALSA's  OSS
emulation layer (ie. using waeplay or similar applications)?  Based on
the options, gstreamer may (or may not) use the OSS emulation.  May want
to try it out to see if that makes a difference.

Regards,

Steve
