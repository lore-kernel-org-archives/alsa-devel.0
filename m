From: Adam Tla/lka <atlka@pg.gda.pl>
Subject: Re: alsa-lib & oss 1.0.3rc1
Date: Fri, 27 Feb 2004 15:18:44 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040227141843.GB25734@sunrise.pg.gda.pl>
References: <1077754003.2680.26.camel@thor.asgaard.local> <Pine.LNX.4.58.0402261129550.13076@pnote.perex-int.cz> <1077804788.27443.51.camel@thor.asgaard.local> <Pine.LNX.4.58.0402261510310.13076@pnote.perex-int.cz> <1077805803.2677.67.camel@thor.asgaard.local> <Pine.LNX.4.58.0402261530490.13076@pnote.perex-int.cz> <1077817984.2680.119.camel@thor.asgaard.local> <Pine.LNX.4.58.0402261933560.13076@pnote.perex-int.cz> <1077885495.13385.32.camel@thor.asgaard.local> <20040227134941.GA25734@sunrise.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sunrise.pg.gda.pl (root@sunrise.pg.gda.pl [153.19.40.230])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA29499
	for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2004 15:18:51 +0100
Received: from sunrise.pg.gda.pl (localhost [127.0.0.1])
	by sunrise.pg.gda.pl (8.12.11/8.12.11) with ESMTP id i1REIj1L018258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2004 15:18:45 +0100 (CET)
Received: (from atlka@localhost)
	by sunrise.pg.gda.pl (8.12.11/8.12.11/Submit) id i1REIiBB018256
	for alsa-devel@alsa-project.org; Fri, 27 Feb 2004 15:18:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20040227134941.GA25734@sunrise.pg.gda.pl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 27, 2004 at 02:49:42PM +0100, Adam Tla/lka wrote:
> Back to bzflag. I will be investigating that.
If you debug aoss ioctl call you find that fragshift is set to 12
and maxfrags to 4. I must read the doc and find what is proper but
maybe there is some parameter mistake.
If you swap the parameters then sound is working.
Change in /usr/src/alsa-20040226/alsa-oss/alsa/pcm.c:

case SNDCTL_DSP_SETFRAGMENT:                                            
        {                                                                       
                DEBUG("SNDCTL_DSP_SETFRAGMENT, %p[%x])\n", arg, *(int *)arg);   
                dsp->fragshift = ((*(int *)arg) >> 16) & 0xffff;                
                DEBUG("IN:  fragshift=%d,", dsp->fragshift);                    
                if (dsp->fragshift < 2)                                         
                        dsp->fragshift = 2;                                     
                dsp->maxfrags = *(int *)arg & 0xffff;                           
                DEBUG(" maxfrags=%d\n", dsp->maxfrags);                         
                if (dsp->maxfrags < dsp->fragshift)                             
                        dsp->maxfrags = dsp->fragshift << 1;                    
                DEBUG("OUT: fragshift=%d, maxfrags=%d\n",                       
                         dsp->fragshift,                                        
                         dsp->maxfrags);                                        
                                                                                
                err = oss_dsp_params(dsp);                                      
                break;                                                          
        }         

Regards
-- 
Adam Tla/lka      mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
System  & Network Administration Group           ~~~~~~
Computer Center,  Gdansk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
