From: Paul Davis <pbd@Op.Net>
Subject: Re: Status of ALSA documentation?
Date: Mon, 25 Feb 2002 12:43:55 -0500
Message-ID: <200202251744.MAA19835@renoir.op.net>
In-reply-to: Your message of "Thu, 21 Feb 2002 08:31:48 +0200."
             <Pine.LNX.4.44.0202210823100.3739-100000@ecabase.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Cc: pshirkey@boosthardware.com, kevin@kevindumpscore.com, Andy Wingo <wingo@pobox.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>On Tue, 19 Feb 2002, Patrick Shirkey wrote:
>
>> I have just uploaded a template for the idea PD had to make a complete
>> howto for each card and link it to the sound card matrix or something
>> similar.
>[...]
>> http://www.boosthardware.com/LAU/alsa/template2.html

looks OK. a few nitpicks:

  1) don't point people at /lib/modules ... the structure of this
      tree is different in 2.0, 2.2 and 2.4
  2) don't put a reference to alsamixer in the template; some cards
      have no mixer and so it won't do anything useful
  3) don't assume that they use vi(1)
  4) defining the card name to be of type "hw" might not
       be too smart for naive "consumer" users who
       then try to use any old app with that as the PCM
       device name.

more generally, it doesn't seem useful to me to duplicate the
instructions for building+installing+configuring ALSA for each
card. isn't this what hyperlinks are for? what we need on a per-card
basis is the stuff thats really specific for that card:
 
 * what modules to load  
 * what module parameters the driver takes
 * a lot of explanation about what they do
 * a list of every Control and PCM switch
 * a lot of explanation about what they do
 * a "FAQ" detailing things like:
      - how to get sound from the rear speakers?
      - how to download firmware?
      - how to get new sounds from the synth?
      - how to make the synth work?
      - why do i have to preload module XXX?

>> http://www.boosthardware.com/LAU/alsa/

doesn't render under netscape 4.0

I think that simply for working on this, Patrick should be made
webmaster for alsa-project.org. The simple fact that he has bothered
to do some work on the website moves him beyond almost anybody else on
the list, though in most cases, for all the right reasons.

--p





_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
