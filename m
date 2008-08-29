From: Harald Radke <harryrat@postnuklear.de>
Subject: get rid of controls with snd_ctl_remove
Date: Fri, 29 Aug 2008 14:54:42 +0200
Message-ID: <200808291454.42441.harryrat@postnuklear.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.netbeat.de (mail.netbeat.de [83.243.58.160])
	by alsa0.perex.cz (Postfix) with SMTP id 0B188243F5
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Aug 2008 14:54:44 +0200 (CEST)
Content-Disposition: inline
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

Hi there!

Please be patient with me, I am quite inexperienced with alsa programming, so 
this might be a dumb question:

We have a WM8750 working in our PDA, the codec is working so far but I want to 
remove some of the control since they aren't needed.

Instead of copying the wm8750.c file and adjusting it, I want to write another 
module which basically get rid of those controls, something like:

[...]

static const char* unused_controls[] = {"AAAA", "BBBB,"CCCC"};

        struct snd_kcontrol *ctl;

        list_for_each_entry(ctl, &card->controls, list)
          for(i=0; i <  ARRAY_SIZE(unused_controls); i++)
            if (!strcmp(unused_controls[i],ctl->id.name)) {
              down_write(&card->controls_rwsem);
              snd_ctl_remove(card,ctl);
              up_write(&card->controls_rwsem);
              break;
            }

unfortunatly this doesn't work (module segfaults...."of course" you will say 
*g*)

My question: is it possible at all and I am just not deep nuff in understanding 
the sound system or do I have to adjust the original code?

Thx

Harry
