From: Brolin Empey <f7@dccnet.com>
Subject: Re: example of sending note on/off to MIDI port	(Timidity's
 virtual sequencer)
Date: Thu, 20 Oct 2005 20:19:59 -0700
Message-ID: <43585E5F.7040603@dccnet.com>
References: <4358068C.3050405@dccnet.com> <1129850256.7918.6.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1129850256.7918.6.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
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

Lee Revell wrote:
> On Thu, 2005-10-20 at 14:05 -0700, Brolin Empey wrote:
>> Hello,
>>
>> I want to add ALSA support to a MIDI program I wrote (in C) which 
>> currently supports only the Win32 API (using midiOutShortMsg).  More 
>> specifically, I want to do this using Timidity's virtual sequencer for 
>> playback of the output MIDI messages.  I can use playmidi (which uses 
>> the OSS API) or pmidi (which uses ALSA's API) to play MIDI files using 
>> Timidity's port (128:0).  After studying both of these application's 
>> sources, I tried without success to put together a minimal test program 
>> to simply send a note on and subsequent note off message using 
>> Timidity's port.
>>
>> Does anyone have a simple example of how to do this?  It can use either 
>> the OSS API (e.g. /dev/sequencer interface) or ALSA's library.  I tried 
>> the rawmidi example, but could not get it to play anything using 
>> Timidity's port.
> 
> You forgot to include a link to your code.
> 
> Lee

I don't think this will be too helpful since I used a bunch of functions 
from the pmidi source.  I was asking if anyone had a working example 
because I wanted something simple that worked and that I could build 
upon.  I was under the impression that what I wanted to do seemed to be 
quite complex, especially compared to using the Win32 API to do the same 
thing.  This impression may be quite wrong though, since I haven't 
studied the documentation too much and was hoping to just piece 
something together from pmidi.

=======================================================================

#define HAVE_ALSA_ASOUNDLIB_H 1

#include "glib.h"
#include "elements.h"
#include "except.h"
#include "intl.h"

#include "seqlib.h"
#include "md.h"
#include "midi.h"

#include <alsa/asoundlib.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <getopt.h>
#include <string.h>
#include <errno.h>
#include <signal.h>

int
main(int argc, char **argv)
{
	static char optstring[] = "p:";
   	static struct option longopts[] = {
	  { "port",      required_argument,            0,              'p' },
	  { 0,      0,            0,              0 },
	};
	int ex=0, ch=0, client=0, port=0, i=0, j=0, k=0, l=0;
	char *cp;
	//char n[3];
	seq_context_t *ctxp;
	snd_seq_event_t ev;

	/*
	for (i=0; i<sizeof(n)/sizeof(n[0]); i++)
	{
	  n[i] = 0;
	}
	*/
	//memset(n, 0, sizeof(n)/sizeof(n[0]));

	while ( (ex == 0) && ( (ch = getopt_long(argc, argv, optstring, 
longopts, NULL)) != EOF) )
	{
		switch (ch)
		{
			case 'p':
			  if (!optarg)
			  {
			    exit(1);
			  }
			  /*
			  cp = strchr(optarg, ':');
			  printf("optarg start = %d, : = %d\n", &optarg, &cp[0]);
			  printf("client = %s\n", cp);
			  */
			  for (i=0; i<strlen(optarg); i++)
			  {
			    if (optarg[i] == ':')
			    {
			      j = i;
			      break;
			    }
			  }
			  // printf("':' at %d chars from start.\n", j);
			  if (j > 0)
			  {
			    cp = calloc(j+1, sizeof(optarg[0]));
			    for (i=0; i<j; i++)
			    {
			      cp[i] = optarg[i];
			    }
			    //printf("client (as string) = %s\n", cp);
			    client = atoi(cp);
			    //printf("client (as int) = %d\n", client);
			    free(cp);

			    k = strlen(optarg)-(j+1);
			    //printf("k = %d\n", k);
			    if (k>0)
			    {
			      cp = calloc(k, sizeof(optarg[0]));
			      //printf("strlen(optarg)-(j+1) = %d\n", strlen(optarg)-(j+1));
			      //printf("j = %d\n", j);
			      l = j+1;
			      for (i=0; i<k; i++)
			      {
				//printf("i = %d\n", i);
				cp[i] = optarg[l];
				l++;
			      }
			      //printf("port (as string) = %s\n", cp);
			      port = atoi(cp);
			      //printf("port (as int) = %d\n", port);
			      free(cp);
			    }
			  }
			  break;
		default:
		  ex = 1;
		  break;
		}
	}
	if (ex)
	{
	  return ex;
	}

	ctxp = seq_create_context();

	if (seq_connect_add(ctxp, client, port) < 0)
	{
	  fprintf(stderr, "Could not connect to port %d:%d\n", client, port);
	  return 1;
	}

	seq_midi_event_init(ctxp, &ev, 1000, 0);

	seq_init_tempo(ctxp, 8, 120, 1);
	seq_start_timer(ctxp);
	seq_midi_program(ctxp, &ev, 0, 0);

	seq_midi_note(ctxp, &ev, 0, 60, 127, 1000);
	sleep(5);

	seq_free_context(ctxp);
	
	return ex;
}


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
