From: Gerald Grabner <gerry@mechanik.tu-graz.ac.at>
Subject: Re: Easy question: ppq and tempo
Date: Fri, 31 May 2002 18:44:42 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CF7A87A.E1D828D0@mechanik.tu-graz.ac.at>
References: <Pine.LNX.4.21.0205241612070.761-100000@summer.quitte> <200205241435.QAA00530@alsa.alsa-project.org> <20020524173546.GA23700@idefix.fvdpol.home.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailrelay.tugraz.at (mailrelay.tu-graz.ac.at [129.27.3.7])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA03648
	for <alsa-devel@alsa-project.org>; Fri, 31 May 2002 18:45:20 +0200
Received: from fmechgsg01.tu-graz.ac.at (fmechgsg01.tu-graz.ac.at [129.27.94.2])
	by mailrelay.tugraz.at (8.12.3/8.12.3) with ESMTP id g4VGjaaW008231
	for <alsa-devel@alsa-project.org>; Fri, 31 May 2002 18:45:36 +0200 (MEST)
Received: from mechanik.tu-graz.ac.at (isdn126.tu-graz.ac.at [129.27.240.126])
	by fmechgsg01.tu-graz.ac.at (SGI-8.9.3/8.9.3) with ESMTP id SAA52833
	for <alsa-devel@alsa-project.org>; Fri, 31 May 2002 18:45:10 +0200 (METDST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

last week I asked about the meaning of ppq - thanks a lot so far for
all the answers! Now I have a related question, namely about tempo: If
I set ppq to 1, then tempo should be the duration of a quarter note in
microseconds, right?

But there seems to be a factor of about 100 between this and what I
get with my test program. Setting tempo to 100000000 makes one quarter
last about one second. Is there something wrong with my program or
what's my mistake?

Thanks again,
       Gerald

--

  snd_seq_queue_tempo_t *queue_tempo ;
  snd_seq_get_queue_tempo (seq_handle, queue_id, queue_tempo) ;
  int ppq = 1 ;
  snd_seq_queue_tempo_set_ppq (queue_tempo, ppq) ;
  unsigned int tempo = 100000000 ;
  snd_seq_queue_tempo_set_tempo (queue_tempo, tempo) ;
  snd_seq_set_queue_tempo (seq_handle, queue_id, queue_tempo) ;

  snd_seq_ev_clear(&ev);
  snd_seq_ev_set_source(&ev, port_id);
  snd_seq_ev_set_subs(&ev);
  snd_seq_ev_set_noteon(&ev, 9, 60, 127) ;
  snd_seq_tick_time_t tick = 0 ;
  for ( int i=0 ; i<4 ; i++ ) {
    snd_seq_ev_schedule_tick(&ev, queue_id,  0, tick);
    snd_seq_event_output(seq_handle, &ev);
    tick++ ;
  }
  snd_seq_drain_output(seq_handle);

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
