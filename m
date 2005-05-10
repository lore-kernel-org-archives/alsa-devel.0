From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Device name lists
Date: Tue, 10 May 2005 17:19:08 +0200
Message-ID: <1115738349.12058.7.camel@pegasus>
References: <1114266960.10706.30.camel@pegasus>
	 <Pine.LNX.4.58.0505090950410.1843@pnote.perex-int.cz>
	 <1115626583.8949.124.camel@pegasus>
	 <Pine.LNX.4.58.0505091028000.1843@pnote.perex-int.cz>
	 <1115629642.8949.150.camel@pegasus>
	 <Pine.LNX.4.58.0505101257530.1834@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.holtmann.net (coyote.holtmann.net [217.160.111.169])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 080202E3
	for <alsa-devel@alsa-project.org>; Tue, 10 May 2005 17:18:44 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.58.0505101257530.1834@pnote.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Jaroslav,

> 	I've added the functions handling device name list to alsa-lib.
> Because alsa-lib open functions handle virtual names, it's impossible to
> get list of all possible device names. The interface is:
> 
> typedef struct snd_devname snd_devname_t;
> 
> struct snd_devname {
>         char *name;
>         char *comment;
>         snd_devname_t *next;
> };
> 
> int snd_names_list(const char *interface, snd_devname_t **list);
> void snd_names_list_free(snd_devname_t *list);
> 
> 	As you can see, it simple as possible. The applications might 
> request for a device list which can be generated automagically or advanced
> users might create their own lists.
> 	The lookup is this:
> 
> 1) file specified with ALSA_NAMES_FILE environment variable
> 2) ~/.asoundnm
> 3) /etc/asound.names
> 
> 	Note that 2) and 3) files are not merged (only one file is 
> parsed)!!! The syntax of these files is quite straighforward (alsa-lib
> keeps the order of device compounds):
> 
> timer {
>         alsactl1 {
>                 name 'hw:CLASS=1,SCLASS=0,CARD=-1,DEV=0,SUBDEV=0'
>                 comment 'Physical Device - system timer'
>         }
> }
> 
> 	The alsactl tool was extended to generate a basic set of
> device names (might be extended to detect other plugins as well). This 
> command will generate /etc/asound.names file:
> 
> 	alsactl names
> 
> To generate the user file use:
> 
> 	alsactl -f ~/.asoundnm names
> 
> 
> It's still time to do any changes and I would really appreciate 
> comments...

this is prefect and I hope that the ALSA library users adapt this very
soon, but two questions came to my mind:

1) What is the reason for not merging /etc/asound.names and ~/.asoundnm?

2) Is another config file really needed? Why not add another parameter
called "name" to the current config file. So that I can simply create
this entry for my Bluetooth headphone from HP:

	pcm.hp {
	        type a2dp
	        name "HP stereo headphone"
	        bdaddr "00:0D:44:xx:xx:xx"
	}

If the name value is present then snd_names_list() will show it and
otherwise not. Telling people to add entries in two files sounds not
right to me.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
