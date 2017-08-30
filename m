From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: ALSA hang on 4.13.0-rc7
Date: Wed, 30 Aug 2017 14:26:51 +0200
Message-ID: <20170830122651.GA289@x4>
References: <20170830100334.GA281@x4> <s5hval55mg5.wl-tiwai@suse.de>
 <20170830113340.GA284@x4> <s5hr2vt5lx7.wl-tiwai@suse.de>
 <20170830114241.GA285@x4> <s5hmv6h5lcp.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.ud10.udmedia.de (ud10.udmedia.de [194.117.254.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 832A5266C5E
 for <alsa-devel@alsa-project.org>; Wed, 30 Aug 2017 14:26:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hmv6h5lcp.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 2017.08.30 at 13:46 +0200, Takashi Iwai wrote:
> On Wed, 30 Aug 2017 13:42:41 +0200,
> Markus Trippelsdorf wrote:
> > 
> > On 2017.08.30 at 13:34 +0200, Takashi Iwai wrote:
> > > On Wed, 30 Aug 2017 13:33:40 +0200,
> > > Markus Trippelsdorf wrote:
> > > > 
> > > > On 2017.08.30 at 13:23 +0200, Takashi Iwai wrote:
> > > > > On Wed, 30 Aug 2017 12:03:34 +0200,
> > > > > Markus Trippelsdorf wrote:
> > > > > > 
> > > > > > On my system ALSA sometimes hangs:
> > > > > > 
> > > > > >  sysrq: SysRq : Show Blocked State                                         
> > > > > >    task                        PC stack   pid father                       
> > > > > >  output:ALSA def D    0   171      1 0x00000000                            
> > > > > >  Call Trace:                  
> > > > > >   ? __schedule+0x17c/0x720    
> > > > > >   ? schedule_preempt_disabled+0x2d/0x80                                    
> > > > > >   ? __mutex_lock_slowpath+0x141/0x420                                      
> > > > > >   ? snd_pcm_common_ioctl1+0x2f/0x1400                                      
> > > > > >   ? snd_pcm_common_ioctl1+0x2f/0x1400                                      
> > > > > >   ? snd_card_file_remove+0x76/0x120                                        
> > > > > >   ? snd_pcm_playback_ioctl+0x1c7/0x560                                     
> > > > > >   ? dput+0xb6/0x1e0           
> > > > > >   ? SyS_ioctl+0xa7/0x860      
> > > > > >   ? task_work_run+0x70/0xa0   
> > > > > >   ? entry_SYSCALL_64_fastpath+0x13/0x94  
> > > > > > 
> > > > > > Only a reboot will fix the issue.
> > > > > 
> > > > > Is this a regression?

The issue started with:

commit 68b4acd322494444803a3f49884ae889c8ec6689 (HEAD, refs/bisect/bad)
Author: Takashi Iwai <tiwai@suse.de>
Date:   Tue May 24 15:07:39 2016 +0200

    ALSA: pcm: Apply power lock globally to common ioctls

-- 
Markus
