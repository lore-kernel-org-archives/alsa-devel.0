From: "Christophe Osuna" <christophe.osuna@gmail.com>
Subject: mixer callback - help needed
Date: Tue, 27 Jun 2006 20:22:04 +0200
Message-ID: <b6251a620606271122g286b33a7tdba872519b8b7e70@mail.gmail.com>
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
To: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I am trying to implement a simple mixer. Changing volume is fine but I
am stuck with the callback for mixer events.

I couldn't find lots of documentation, so I have tried to mimic what
is done in alsamixer. However I must have missed something because it
does not work. I only call snd_mixer_set_callback; it seems it is not
enough but what else is needed?

Below is a program just to show what I am trying to do. Could anyone
give me hand with this?

Thanks in advance.



#include <stdio.h>
#include <alsa/asoundlib.h>

char * device_name = "default";

/* The callback I can't make be called */
static int mixer_event (snd_mixer_t *mixer_handle, unsigned int mask,
			snd_mixer_elem_t *elem)
{
  printf ("New mixer event\n");
  return 0;
}


int main (int argc, char *argv [])
{
  snd_mixer_t * mixer_device;
  snd_mixer_elem_t * master_element;
  snd_mixer_selem_id_t *sid;
  int err;

  if ((err = snd_mixer_open(&mixer_device, 0)) < 0)
    {
      printf ("Mixer %s open error: %s\n", device_name,
	      snd_strerror(err));
      return err;
    }

  if ((err = snd_mixer_attach(mixer_device, device_name)) < 0)
    {
      printf ("Mixer attach %s error: %s\n", device_name,
	      snd_strerror(err));
      goto error;
    }

  if ((err = snd_mixer_selem_register(mixer_device, NULL, NULL)) < 0)
    {
      printf ("Mixer register error: %s\n", snd_strerror(err));
      goto error;
    }

  /* Set the callback - does not work (something else missing?) */
  snd_mixer_set_callback (mixer_device, mixer_event);

  if ((err = snd_mixer_load(mixer_device)) < 0)
    {
      printf ("Mixer %s load error: %s\n", device_name, snd_strerror(err));
      goto error;
    }

  snd_mixer_selem_id_alloca (&sid);

  snd_mixer_selem_id_set_index (sid, 0);
  snd_mixer_selem_id_set_name (sid, "Master");

  if (!(master_element = snd_mixer_find_selem(mixer_device, sid)))
    {
      printf ("Unable to find simple control '%s', %i\n",
	      snd_mixer_selem_id_get_name(sid),
	      snd_mixer_selem_id_get_index(sid));
      err = -ENOENT;
      goto error;
    }

  if (! snd_mixer_selem_has_playback_volume(master_element))
    {
      printf ("Device %s does not allow changing playback volume\n",
	      device_name);
      err = -ENOENT;
      goto error;
    }

  while (1)
    {
      sleep (1);
    }

  snd_mixer_close (mixer_device);
  return 0;

 error:
  snd_mixer_close (mixer_device);
  return err;
}

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
