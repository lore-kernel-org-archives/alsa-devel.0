From: "Christophe Osuna" <christophe.osuna@gmail.com>
Subject: Unable to poll() or select() with PCM capture device
Date: Tue, 27 Feb 2007 14:20:37 +0100
Message-ID: <b6251a620702270520l63c5576sae91a31801e919e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I am trying to use select() on ALSA devices but it does not work. I
must be missing something. Does anyone have an idea of what is wrong
with my code?

The following function works (it prints '+' whenever a new frame is ready):

void capture (snd_pcm_t *capture_handle, short *buffer,
			     int samples)
{
	while (1) {
		snd_pcm_readi (capture_handle, buffer, samples);
		printf ("+");
		fflush (stdout);
	}
}


The following uses select(). I can't get any '+' to be printed. If I
'ls -l' the file descriptor in /proc/<pid>/fd/ I can see that it is
the file descriptor of the capture device (as expected). If I use a
playback device (SND_PCM_STREAM_PLAYBACK) and the writefds of select
() the program is not blocked in the select ().

void capture_with_select (snd_pcm_t *capture_handle, short *buffer,
			  int samples)
{
	struct pollfd ufds;
	fd_set fds;

	int count = snd_pcm_poll_descriptors_count (capture_handle);
	
	if (snd_pcm_poll_descriptors(capture_handle, &ufds, count) < 0) {
		printf ("Can't get poll descriptor\n");
		exit (EXIT_FAILURE);
	}

	printf ("File descriptor: %d\n", ufds.fd);

	while (1) {
		FD_ZERO (&fds);
		FD_SET (ufds.fd, &fds);

		select (ufds.fd + 1, &fds, NULL, NULL, NULL);

		snd_pcm_readi (capture_handle, buffer, samples);
		printf ("+");
		fflush (stdout);
	}
}


Using poll() gives the same results; the program is blocked in poll()
when using a capture device.

void capture_with_poll (snd_pcm_t *capture_handle, short *buffer,
			int samples)
{
	struct pollfd ufds;
	unsigned short revents;

	int count = snd_pcm_poll_descriptors_count (capture_handle);
	
	if (snd_pcm_poll_descriptors(capture_handle, &ufds, count) < 0) {
		printf ("Can't get poll descriptor\n");
		exit (EXIT_FAILURE);
	}

	printf ("File descriptor: %d\n", ufds.fd);

	while (1) {
		poll (&ufds, count, -1);
		snd_pcm_poll_descriptors_revents (capture_handle, &ufds, count,
						  &revents);

		if (revents & POLLIN) {
			snd_pcm_readi (capture_handle, buffer, samples);
			printf ("+");
			fflush (stdout);
		}
		else {
			printf ("?");
			fflush (stdout);
		}
	}
}

Tested on:
_ Mandriva 2006, ALSA 1.0.9, USB sound device
_ SUSE 10.1, ALSA 1.0.11, USB sound device, SB Live! and ICH7 AC'97

Any idea of what is wrong and why it works with playback device but
not capture device?

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
