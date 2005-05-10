From: Jaroslav Kysela <perex@suse.cz>
Subject: Device name lists
Date: Tue, 10 May 2005 13:21:18 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0505101257530.1834@pnote.perex-int.cz>
References: <1114266960.10706.30.camel@pegasus>
 <Pine.LNX.4.58.0505090950410.1843@pnote.perex-int.cz>  <1115626583.8949.124.camel@pegasus>
  <Pine.LNX.4.58.0505091028000.1843@pnote.perex-int.cz> <1115629642.8949.150.camel@pegasus>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 571E1301
	for <alsa-devel@alsa-project.org>; Tue, 10 May 2005 13:21:20 +0200 (MEST)
In-Reply-To: <1115629642.8949.150.camel@pegasus>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
Cc: Marcel Holtmann <marcel@holtmann.org>
List-Id: alsa-devel@alsa-project.org

Hi all,

	I've added the functions handling device name list to alsa-lib.
Because alsa-lib open functions handle virtual names, it's impossible to
get list of all possible device names. The interface is:

typedef struct snd_devname snd_devname_t;

struct snd_devname {
        char *name;
        char *comment;
        snd_devname_t *next;
};

int snd_names_list(const char *interface, snd_devname_t **list);
void snd_names_list_free(snd_devname_t *list);

	As you can see, it simple as possible. The applications might 
request for a device list which can be generated automagically or advanced
users might create their own lists.
	The lookup is this:

1) file specified with ALSA_NAMES_FILE environment variable
2) ~/.asoundnm
3) /etc/asound.names

	Note that 2) and 3) files are not merged (only one file is 
parsed)!!! The syntax of these files is quite straighforward (alsa-lib
keeps the order of device compounds):

timer {
        alsactl1 {
                name 'hw:CLASS=1,SCLASS=0,CARD=-1,DEV=0,SUBDEV=0'
                comment 'Physical Device - system timer'
        }
}

	The alsactl tool was extended to generate a basic set of
device names (might be extended to detect other plugins as well). This 
command will generate /etc/asound.names file:

	alsactl names

To generate the user file use:

	alsactl -f ~/.asoundnm names


It's still time to do any changes and I would really appreciate 
comments...

The API is indended mainly for GUI applications or as a source of 
information for command line tools.

The aplay/arecord tool has now '-n' option which allows listing
of device names using this new API.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
