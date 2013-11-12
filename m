From: Dolevo Jay <cmst@live.com>
Subject: Re: How to apply rate conversion in asound.conf
Date: Tue, 12 Nov 2013 09:02:52 +0000
Message-ID: <DUB122-W16D7B544467C56A6156AEAAAFE0@phx.gbl>
References: <DUB122-W45C29A2FD0EE3B2FC1A459AAF00@phx.gbl>, ,
 <527A6EA1.4080909@ladisch.de>,
 <DUB122-W390A38324ACF50DA28405BAAF20@phx.gbl>,
 <DUB122-W40354113C10D5F94B582F2AAF20@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dub0-omc3-s3.dub0.hotmail.com (dub0-omc3-s3.dub0.hotmail.com
 [157.55.2.12]) by alsa0.perex.cz (Postfix) with ESMTP id A5D5826087D
 for <alsa-devel@alsa-project.org>; Tue, 12 Nov 2013 10:02:53 +0100 (CET)
In-Reply-To: <DUB122-W40354113C10D5F94B582F2AAF20@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



> From: cmst@live.com
> To: alsa-devel@alsa-project.org
> Date: Fri, 8 Nov 2013 14:15:30 +0000
> Subject: Re: [alsa-devel] How to apply rate conversion in asound.conf
> 
> 
> 
> 
> 
> > Date: Wed, 6 Nov 2013 17:30:25 +0100
> > From: clemens@ladisch.de
> > To: cmst@live.com; alsa-devel@alsa-project.org
> > Subject: Re: [alsa-devel] How to apply rate conversion in asound.conf
> > 
> > Dolevo Jay wrote:
> > > pcm.!default {
> > > 	type plug
> > > 	slave.pcm multi
> > > }
> > >
> > > pcm.multi {
> > >         slaves.a.pcm "hw:0,1";
> > >         slaves.b.pcm "hw:1,1";
> > > ...
> > >
> > > My purpose is to apply rate conversion to the "hw:1,1" and have 44100 rate
> > > out.
> > 
> > All slaves must use the same rate.
> > 
> > The easiest way is apply this to the plug plugin:
> > 
> > pcm.!default {
> > 	type plug
> > 	slave {
> > 		pcm multi
> > 		rate 44100
> > 	}
> > }
> > 
> > 
> > Regards,
> > Clemens
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
> Hi,
> 
> What you suggested worked perfect but I implemented the rate conversion in my software for some specific reasons.
> What I need to do now is to have a aosund.conf which has dmix into multi plugins together. 
> So, here is my multi configuration:
> --------------------------------
> pcm.!default {
> 	type plug
> 	slave.pcm multi
> }
>  
> pcm.multi {
>         type multi;
>         slaves.a.pcm "hw:0,1";
>         slaves.a.channels 2;
>         slaves.b.pcm "hw:1,1";
>         slaves.b.channels 2;
>  
>         bindings.0.slave a;
>         bindings.0.channel 0;
>         bindings.1.slave a;
>         bindings.1.channel 1;
>         bindings.2.slave b;
>         bindings.2.channel 0;
>         bindings.3.slave b;
>         bindings.3.channel 1;
> }
> 
> --------------------------------
> The following dmix runs ok for 1,1 hardware:
> --------------------------------
> pcm.dmixer {
>     type dmix
>     ipc_key 2048
>     slave {
>         pcm "hw:1,1"
>     }
>     bindings {
>         0 0
>         1 1
>     }
> }
> 
> pcm.!default {
>     type plug
>     slave.pcm dmixer
> }
> --------------------------------
> 
> Could you please tell me how I can implement the second configuration with dmixer into the first one which has multi. 
> So, basically how can I call a plugin inside of another plugin?
> 
> Thanks a lot.
> 
>  		 	   		   		 	   		  
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


Hello,

I'd appreciate if someone could tell me even this is possible or not?

Thanks.
 		 	   		  
