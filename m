From: Tim Goetze <tim@quitte.de>
Subject: Re: Easy question: ppq and tempo
Date: Fri, 24 May 2002 12:48:15 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0205241242240.761-100000@summer.quitte>
References: <3CEDF24F.2080503@mechanik.tu-graz.ac.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from post.webmailer.de (natwar.webmailer.de [192.67.198.70])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id MAA29963
	for <alsa-devel@alsa-project.org>; Fri, 24 May 2002 12:51:19 +0200
In-Reply-To: <3CEDF24F.2080503@mechanik.tu-graz.ac.at>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Gerald Grabner <gerry@mechanik.tu-graz.ac.at>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Gerald Grabner wrote:

>Hi,
>
>I'm just starting to write my first alsa-lib midi applications. I'm 
>wondering what the acronym ppq stands for and what it means (especially 
>in relation to tempo). Unfortunately, I didn't find any docu on the 
>topic of tempo.

from <sound/asequencer.h>:

/* queue tempo */
struct sndrv_seq_queue_tempo {
  int queue;      /* sequencer queue */
  unsigned int tempo;   /* current tempo, us/tick */
  int ppq;      /* time resolution, ticks/quarter */
  unsigned int skew_value;  /* queue skew */
  unsigned int skew_base;   /* queue skew base */
  char reserved[24];    /* for the future */
};

the value is usually synonymous to the 'division' of a standard midi
file. 

tim


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
