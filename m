From: rob buse <rcbuse@filter24.org>
Subject: seq question - snd_seq_ev_schedule_tick();
Date: Mon, 3 Jun 2002 20:12:46 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020603201246.C1804@filter24.mshome.net>
Reply-To: rcbuse@filter24.org
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


I have an event that I want to schedule..

snd_seq_ev_schedule_tick( &ev, queue, 0, tick);

What is that tick relative to?  When I start running the queue ? or
when I call snd_seq_drain_output( ) ? or when snd_seq_event_output() is 
called?

sorry if this is a dumb question.

thanks
.buse

----------------------------------------------------------
music + technology                     http://filter24.org

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
