From: Giuliano Pochini <pochini@shiny.it>
Subject: RE: [App development] - Need list of hardware devic
Date: Fri, 11 Jul 2003 10:24:07 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20030711102407.pochini@shiny.it>
References: <200307082029.21801.gkajmowi@tbaytel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200307082029.21801.gkajmowi@tbaytel.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Garrett Kajmowicz <gkajmowi@tbaytel.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 09-Jul-2003 Garrett Kajmowicz wrote:
> I'm just begining my first ALSA application.  As a part of the GUI I need to
> prompt the user to select from a list the soundcard and input device for both
> recording and playback.  How would you suggest doing this?  Examples welcome.

Try this:


int err, i, n, cardnum;
char devname[8], cardname[32];
snd_ctl_card_info_t *hw_info;


  // Scans all installed cards
  snd_ctl_card_info_alloca(&hw_info);
  cardnum=-1;
  ctlhandle=0;

  while (snd_card_next(&cardnum)>=0 && cardnum>=0) {
    sprintf(devname, "hw:%d", cardnum);
    if ((err=snd_ctl_open(&ctlhandle, devname, 0))<0) {
      printf("snd_ctl_open(%s) Error: %s\n", devname, snd_strerror(err));
      continue;
    }
    if ((err=snd_ctl_card_info(ctlhandle, hw_info))>=0) {
      if (!strcmp(snd_ctl_card_info_get_driver(hw_info), "Echoaudio")) {
        strcpy(card, devname);
        strcpy(cardname, snd_ctl_card_info_get_name(hw_info));
        printf("Card found: %s  (%s)\n", snd_ctl_card_info_get_longname(hw_info), devname);
        break;
      }
    } else {
      printf("snd_ctl_card_info(%s) Error: %s\n", devname, snd_strerror(err));
      exit(1);
    }
    snd_ctl_close(ctlhandle);
    ctlhandle=0;
  }

  if (!ctlhandle) {
    printf("No Echoaudio cards found, sorry.\n");
    return(0);
  }



Bye.



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
