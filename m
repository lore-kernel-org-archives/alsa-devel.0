From: Benouille <benouille@ifrance.com>
Subject: Re: hdsp9632 mixer fix + gcc 2.9x compile fix
Date: Fri, 07 Nov 2003 14:20:35 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FAB9C23.9020004@ifrance.com>
References: <3FAA408F.50201@undata.org> <3FAB5CE6.70306@ifrance.com> <3FAB857A.80707@undata.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FAB857A.80707@undata.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thanks thomas,

you're right, I'm french... and your answer was very clear!
/Franchement tu fais un super bouleau, et notamment le hdspmixer est une 
pure
merveille./

Since this mailing list is not in french , I prefer to answer in english.

About the problem of loading the firmware in the hdsp multiface, I'll 
try to explain my experience:
After I boot linux, the multiface is still locked (red light host error 
is on). Then, I need to run hdsploader 3 or 5 times (maybe I should wait 
a bit more between each one). Then, if I run hdspmixer to recall the 
preset 1, I still can't hear any sound from the soundcard, and all 
levels meters in hdspmixer stay null.
If I reboot, no need to run hdsploader, since the firmware is already 
there, I run hdspmixer, and here I can get output from the card.

It's not problematic, I just share my exeperience.
For info: redhat 9, alsa cvs november 5th, Planet CCRMA kernel 2.4.22, 
hdsp flash firmware v1.1

A last question I know someone that have a hdsp 9652 with RME Analog 
Expansion Board : 2 * 8 channels output and one 8 channels input. He 
would like to install linux, do you know if it should work without 
problem? (synchro problems?)

Thanks, thanks, and one more time: THANKS!

Benoit



Le 07/11/2003 12:43, Thomas Charbonnel a écrit :

> Benouille wrote :
> 
>> Hi thomas,
>>
>> A big thank you for all your great job on the rme hdsp.
>> I've installed the alsa cvs dated from the november 5th on 2 pc:
>> one with a hdsp multiface, one with a hdsp 9652.
>>
>> Since this update, I can't access anymore the level of the channels with
>> amixer, and alsamixer reponds 'no mixer element found' on both system. 
>> Is it a normal behaviour?
> 
> 
> Hello Benoît,
> 
> Vu ton adresse mail et ton prénom, je présume que je peux te répondre en 
> français ?
> J'ai en effet supprimé les contrôles de volumes standards dans la 
> dernière version du driver, parce qu'il n'y avait aucun moyen élégant de 
> les gérer lors des changements de mode (normal speed, double speed, et 
> même quad speed pour les hdsp 9632). Ma décision est aussi basée sur le 
> fait tu peux toujours faire la même chose qu'eux soit avec hdspmixer, 
> soit même en mode console avec amixer et le contrôle appelé 'Mixer'.
> 
> La syntaxe d'amixer est la suivante :
> 
> amixer -c X cset numid=5 in,out,level
> 
> Où X est le numéro de carte alsa de ton hdsp (tu peux ommetre l'option 
> -c si ton hdsp est la carte par défaut)
> 0  <=  in   < 26    entrées physiques
> 26 <=  in   < 52    playbacks (sorties logicielles)
> 0  <=  out  < 26    sorties physiques
> 26 <=  out  <= 27   line out (phones) (sauf pour ta 9652)
> 0  <= level < 65536 niveau sonore (65535 = +6dB, 32768 = 0dB)
> 
> Un exemple rapide :
> 
> amixer cset numid=5 26,0,32768
> amixer cset numid=5 27,1,32768
> 
> Ceci route les sorties logicielles un et deux vers les sorties physiques 
>  un et deux (la même chose que si tu avait mis le niveau à 50 % dans les 
> deux premières tranches d'alsamixer).
> 
> Voici un petit script bash pour router toutes les sorties logicielles 
> dans les sorties physiques correspondante ansi que la sortie casque 
> (c'est l'équivalent du preset 1 de totalmix/hdspmixer):
> 
> #! /bin/bash
> 
> for out_left in $(seq 0 2 25);
> do
> let out_right=$out_left+1
> let in_left=$out_left+26
> let in_right=$out_right+26
> amixer -c 2 cset numid=5 $in_left,$out_left,32768
> amixer -c 2 cset numid=5 $in_left,26,32768
> amixer -c 2 cset numid=5 $in_right,$out_right,32768
> amixer -c 2 cset numid=5 $in_right,27,32768;
> done;
> 
> 
>>
>> Then, when I boot, the hdsp multiface is still locked and I need to 
>> call 'hdsploader' about 3 or 5 times (I have the 'post-install 
>> snd-hdsp /usr/local/bin/hdsploader' in modules.conf)
>>
> 
> Je suis au courrant de ce problème, mais je n'ai pas encore mis le doigt 
> sur la cause. Généralement lancer hdsploader 2 fois suffit : la première 
> fois le firmware et uploadé comme il faut, mais pour un raison que 
> j'ignore encore le temps d'attente demandé au kernel n'est pas respecté 
> et la fonction retourne une erreur, du coup la carte n'est pas 
> initialisée correctement. Mais tu constateras que la lumière rouge 
> (host) s'est éteinte : la carte est fonctionnelle, mais les 
> périphériques alsa correspondant n'ont pas été créés. Après cela, quand 
> tu lance hdsploader à nouveau, la fonction d'upload se termine 
> correctement, les périphériques alsa sont créés, et la carte est 
> initialisée comme il faut.
> 
> then, I have to reboot, and run hdspmixer to unmute the channels.
> 
> En fait rien n'est muté, mais simplement le matrix mixer est vide.
> 
>> I woul like to know if there is a way to start the system with the 
>> card properly running and all channels unmuted.
>> Maybe you could show us your modules.conf?
>>
> Rien de particulier dans mon modules.conf. J'utilise hdsploader 
> manuellement, et la plupart du temps je ne débranche pas le secteur du 
> boîtier de la multiface, du coup le firmware reste uploadé, et la carte 
> est initialisée comme il faut lors du boot.
> Pour ce qui est de restaurer des valeurs de routages utiles, tu peux 
> utiliser le petit script que je t'ai inclus plus haut.
> 
> Conclusion, il faut décidément que je résolve ce problème 
> d'initialisation...
> 
> Thomas
> 
> 
> _____________________________________________________________________
> Envie de discuter en "live" avec vos amis ? Télécharger MSN Messenger
> http://www.ifrance.com/_reloc/m la 1ère messagerie instantanée de France
> 


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
