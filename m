From: Oliver Schinagl <oliver@schinagl.nl>
Subject: Volume and other questions.
Date: Mon, 27 Nov 2006 20:07:05 +0100
Message-ID: <456B3759.1060304@schinagl.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
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

first of all, hello, I'm a new to alsa development and was hoping I
could learn a thing or two here.

So here's the questions I have.

What's up with the documentation, specifically the API docs. It's ...
not easy figureing stuff out from the doxygen generated docs. Right now
I'm looking specifically at the:
void snd_mixer_selem_get_id (snd_mixer_elem_t *elem,
	snd_mixer_selem_id_t *id)  	


Get mixer simple element identifier.

*Parameters:*
	/elem/	Mixer simple element handle
	/id/	returned mixer simple element identifier

unsigned int snd_mixer_selem_id_get_index(const snd_mixer_selem_id_t 
*obj)  	

Get index part of a mixer simple element identifier.

*Parameters:*

  	/obj/	Mixer simple element identifier

*Returns:*
    index part

For example. Would you know what these functions do?

I THINK (and thus the question) that snd_mixer_selem_get_id(); fills (so 
why not snd_mixer_selem_id_fill()) the elem id based on the elem we have 
(via snd_mixer_first_elem() for example) and then we can query the two 
fields from the struct via snd_mixer_selem_id_get_index and 
snd_mixer_selem_id_get_name.
But then I wonder, how is this linked to an elem? What's the point of
get id? Isn't this info in elem also? If I wanted to do some accounting,
I'd have to have a struct with the elem and the sid (pointers) in it and
than use the sid to identify the elem? Since there's also an
snd_mixer_selem_get_name()
call, what's the point in having 2 identical structures? I don't get it,
and the documentation doesn't help at all regarding to this.


Then my second question is the following: If I'd write an application,
that uses alsa to output audio (for simplicities sake, let's look at
xmms), would I be able to add a (software) mixer element for the audio
output and be able to control the volume? I'm wondering this since
there's all these snd_mixer_selem_id_copy()
for example calls. I don't think I as a user am able to copy kernel
contents, so what's the point of this function? If I can do this (why
doens't xmms use it, they do a software volume control it seems, e.g.
very delayed, or is this exactly what I'm asking) can I think of what is
being said about the new Vista volume control crap, except for they dump
it right in the windows mixer, whereas here it's a private mixer/control
to the app that created it (much cleaner I think).

Thanks,

Oliver

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
