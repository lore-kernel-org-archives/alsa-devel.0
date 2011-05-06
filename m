From: hong zhang <henryzhang62@yahoo.com>
Subject: Re: multi channels input and single channel out
Date: Thu, 5 May 2011 17:31:06 -0700 (PDT)
Message-ID: <832427.40358.qm@web161703.mail.bf1.yahoo.com>
References: <20110506002323.GA2581@qtel.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm30-vm0.bullet.mail.bf1.yahoo.com
	(nm30-vm0.bullet.mail.bf1.yahoo.com [98.139.213.126])
	by alsa0.perex.cz (Postfix) with SMTP id 1D63A24350
	for <alsa-devel@alsa-project.org>;
	Fri,  6 May 2011 02:31:08 +0200 (CEST)
In-Reply-To: <20110506002323.GA2581@qtel.sh.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lu Guanqun <guanqun.lu@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

"--separate-channels" option only allows two files for two channels. Interesting thing is plughw:0,1 -c 1 works only for one pin input (two channels). 

plughw:0,1 -c 1 complains overrun for 6 channels (3 input pins) input.

--- On Thu, 5/5/11, Lu Guanqun <guanqun.lu@intel.com> wrote:

> From: Lu Guanqun <guanqun.lu@intel.com>
> Subject: Re: [alsa-devel] multi channels input and single channel out
> To: "hong zhang" <henryzhang62@yahoo.com>
> Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
> Date: Thursday, May 5, 2011, 7:23 PM
> On Fri, May 06, 2011 at 07:47:55AM
> +0800, hong zhang wrote:
> > List,
> > 
> > I have 8 channels of hdmi input and one channel output
> on my board.
> > When arecord -f dat hdmi-rx.wav to store 8 channels
> data, aplay -f dat hdmi-rx.wav releases noise.
> > 
> > Ia there any way arecord stores each channel data to 8
> different files?
> 
> check out the "--separate-channels" option for arecord.
> see if it meets your needs.
> 
> > Or I have to do beam forming to sort 8 channels out by
> custom application?
> > 
> > Thanks.
> > 
> > ---henry
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
> -- 
> guanqun
> 
