From: Paul Davis <pbd@op.net>
Subject: Re: how to define a 2-index control element?
Date: Tue, 07 May 2002 13:17:40 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205071717.g47HH3D25608@post2.fast.net>
References: <s5hg0145jqv.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Tue, 07 May 2002 12:34:48 +0200."
             <s5hg0145jqv.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>, Abramo Bagnara <abramo@alsa-project.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>> If someone has hardware with 1400+ controls, than memory allocation issue 
>> is out of question. I wrote that we can optimize current code - add some 
>> hash tables for faster lookups for example.
>
>well, about 200kB is not so big nowadays :)
>
>i thought the hardware doesn't need allocate 1400 controls - the
>controls are identical but have different indices.
>in such a case, the indexed-access would be most straightforward.
>no hash, no list.

precisely. in fact, there are:

	   1456 mixer controls
	   52   RMS meters
	   80   peak meters

for the mixer controls, they form a matrix that is accessed by
index. for the meters, they form unidimensional arrays that are also
accessed by index.

i think any talk of allocating 1 control per "semantic control" is
crazy. its clear that these controls should be accessed as a matrix
type. they were designed by the h/w people as a matrix, and its been
ALSA's policy to have the kernel API mirror h/w designs and
capabilities. 

i can see no reason for not implementing the matrix type that takashi
suggested. its simple, its clean, it will work for notifications (you
just store the index in the information sent up to user space) and its
flexible for future hardware that use matrix controls.

i'm happy to do the implementation, but jaroslav and abramo seem
opposed to the idea.

--p

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
