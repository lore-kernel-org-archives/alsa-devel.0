From: Taybin Rutkin <trutkin@physics.clarku.edu>
Subject: control switch API/code change? (fwd)
Date: Tue, 12 Feb 2002 16:05:52 -0500 (EST)
Message-ID: <Pine.LNX.3.96.1020212160448.6916A-100000@planck.clarku.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from planck.clarku.edu (mail@planck.clarku.edu [140.232.2.12])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id WAA31929
	for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2002 22:06:02 +0100
Received: from trutkin (helo=localhost)
	by planck.clarku.edu with local-smtp (Exim 3.12 #1 (Debian))
	id 16ak7c-00020D-00
	for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2002 16:05:52 -0500
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

I'm sending this message on behalf of Paul Davis.

---------- Forwarded message ----------
Date: Tue, 12 Feb 2002 15:08:56 -0500
From: Paul Davis <pbd@op.net>
To: trutkin@physics.clarku.edu
Subject: control switch API/code change?

[ TAYBIN: for some reason, i can't send mail to alsa-devel right now.
  Could you forward this for me? Thanks. ]

the code below used to work just fine with an older version of
0.9.X. i just upgraded to current CVS, and found that it now causes a
segfault by overwriting h->driver->ctl_handle, apparently before we
even get to the first snd_ctl_elem_read().

for clarity, h->driver->ctl_handle is a snd_ctl_t previously opened
successfully and correctly initialized on entry to this code.

does this ring any bells in anyone's head about changes in the control
interface code?

--p


static void *
hammerfall_monitor_controls (void *arg)

{
	jack_hardware_t *hw = (jack_hardware_t *) arg;
	hammerfall_t *h = (hammerfall_t *) hw->private;
	snd_ctl_elem_id_t *switch_id[3];
	snd_ctl_elem_value_t *sw[3];

	pthread_setcanceltype (PTHREAD_CANCEL_ASYNCHRONOUS, NULL);

	snd_ctl_elem_id_malloc (&switch_id[0]);
	snd_ctl_elem_id_malloc (&switch_id[1]);
	snd_ctl_elem_id_malloc (&switch_id[2]);

	snd_ctl_elem_value_malloc (&sw[0]);
	snd_ctl_elem_value_malloc (&sw[1]);
	snd_ctl_elem_value_malloc (&sw[2]);

	set_control_id (switch_id[0], "ADAT1 Sync Check");
	set_control_id (switch_id[1], "ADAT2 Sync Check");
	set_control_id (switch_id[2], "ADAT3 Sync Check");

	snd_ctl_elem_value_set_id (sw[0], switch_id[0]);
	snd_ctl_elem_value_set_id (sw[1], switch_id[1]);
	snd_ctl_elem_value_set_id (sw[2], switch_id[2]);

	while (1) {
		if (snd_ctl_elem_read (h->driver->ctl_handle, sw[0])) {
			jack_error ("cannot read control switch 0 ...");
		}
		hammerfall_check_sync (h, sw[0]);

		if (snd_ctl_elem_read (h->driver->ctl_handle, sw[1])) {
			jack_error ("cannot read control switch 0 ...");
		}
		hammerfall_check_sync (h, sw[1]);

		if (snd_ctl_elem_read (h->driver->ctl_handle, sw[2])) {
			jack_error ("cannot read control switch 0 ...");
		}
		hammerfall_check_sync (h, sw[2]);
		
		if (nanosleep (&h->monitor_interval, 0)) {
			break;
		}
	}

	pthread_exit (0);
}


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
