From: Gregor Jasny <jasny@vidsoft.de>
Subject: Mixer Event
Date: Fri, 08 Oct 2004 13:32:12 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <41667ABC.8080805@vidsoft.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060602010203000105040905"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060602010203000105040905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I want to poll a mixer device for events. After setting the callback 
handler i get for every channel a callback with mask 4 (I think this is 
'add device'). But after waiting at poll() and altering the volume of a 
channel I get an error at snd_mixer_poll_descriptors_revents():

snd_mixer_poll_descriptors_revents() POLLNVAL:  Operation not permitted

I've attached the source.

Thanks in advance,
-Gregor

--------------060602010203000105040905
Content-Type: text/x-csrc;
 name="event.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="event.c"

#include <stdlib.h>
#include <stdio.h>
#include <sys/poll.h>

#include <alsa/asoundlib.h>


int
mixer_event (snd_mixer_t *mixer, unsigned int mask, snd_mixer_elem_t *elem)
{
    fprintf(stderr, "EVENT! %x %s\n", mask, snd_mixer_selem_get_name(elem) );

    return 0;
}


int main (int argc, char *argv[])
{
    int count, err, finished;
    struct pollfd *fds;
    unsigned short revents;
    snd_mixer_t *mixer;

    if ((err = snd_mixer_open(&mixer, 0)) < 0) {
        fprintf(stderr, "snd_open_mixer(): %s\n", snd_strerror(-err));
        return -1;
    }
    if ((err = snd_mixer_attach(mixer, "default")) < 0) {
        fprintf(stderr, "snd_mixer_attach(): %s\n", snd_strerror(-err));
        return -1;
    }
    
    if ((err = snd_mixer_selem_register(mixer, NULL, NULL)) < 0) {
        fprintf(stderr, "snd_mixer_selem_register(): %s\n", snd_strerror(-err));
        return -1;
    }   

    snd_mixer_set_callback(mixer, mixer_event);

    if ((err = snd_mixer_load(mixer)) < 0) {
        fprintf(stderr, "snd_mixer_load(): %s\n", snd_strerror(-err));
        return -1;
    }

    if ((count = snd_mixer_poll_descriptors_count(mixer)) < 0) {
        fprintf(stderr, "snd_mixer_poll_descriptors_count(): %s\n", snd_strerror(-err));
        return -1;
    }

    fds = calloc( count, sizeof( struct pollfd ) );

    if ((err = snd_mixer_poll_descriptors(mixer, fds, count)) < 0) {
       fprintf(stderr, "snd_mixer_poll_descriptors(): %s\n", snd_strerror(-err));
        return -1; 
    }
    if (err != count) {
        fprintf(stderr,"snd_mixer_poll_descriptors(): err != count\n");
        return -1; 
    } 
        
    finished = poll(fds, count, -1);
    
    if (finished > 0) {
        if (snd_mixer_poll_descriptors_revents( mixer, fds, count, &revents) >= 0) {
            if (revents && POLLNVAL) {
                fprintf(stderr, "snd_mixer_poll_descriptors_revents() POLLNVAL:  %s\n", snd_strerror(-err));
                return -1; 
            }
            if (revents && POLLERR) {
                fprintf(stderr, "snd_mixer_poll_descriptors_revents() POLLERR: %s\n", snd_strerror(-err));
                return -1; 
            }
            if (revents && POLLIN) {
                snd_mixer_handle_events (mixer);
            }
        }
    }

    free (fds);

    if ((err = snd_mixer_close(mixer)) < 0) {
        fprintf(stderr, "snd_mixer_close(): %s\n", snd_strerror(-err));
        return -1;
    }

    return 0;
}

--------------060602010203000105040905--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
