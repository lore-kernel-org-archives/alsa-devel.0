From: Peter Enderborg <pme@ufh.se>
Subject: Memory managment.
Date: Sun, 05 May 2002 19:35:04 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CD56D48.E0C82404@ufh.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I have some memory problems with my alsa programming.
And I have tryed to do a small program to see whats wrong.
And I still have the same problem with this little program...


#include <alsa/asoundlib.h>
int main()
{
  while (1)
    {
      snd_seq_event_t *foo;
      foo = snd_seq_create_event();
      snd_seq_free_event(foo);
    }
  return 0;
}

I guess that I have missed some fundamental things about the events.
This on cvs version from 20020504


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
