From: Peter Enderborg <pme@ufh.se>
Subject: Re: How to send data trough rawmidi ?
Date: Sat, 06 Apr 2002 22:52:53 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CAF6025.63728278@ufh.se>
References: <20020406155349.D522@pengouin.univ-valenciennes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Charles FlXche <charles.fleche@meletu.univ-valenciennes.fr>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Charles FlXche wrote:

> Hello everybody !
>
> I'm french, so I'll **TRY** to speak english correctly...
>
> I'm new in C programming (in programming, in fact...) and I work on a
> soft for speaking with an effect rack (alesis microverb IV) with sysex
> trough rawmidi for saving my patches, remote control this unit, etc...
>
> So, this is my problem  : I don't know how to send sysex through
> rawmidi !! I'm using the snd_rawmidi_open and snd_rawmidi_write, but I
> can't send anything !! Even the rawmidi.c test program from alsa-utils
> don't work...
>
> My soundcard is an Sound Blaster Live ! 1024 Player...
>
> This is a piece of my source code :
>
> /* START OF SOURCE */
>
> #include <sys/asoundlib.h>
> #include <stdio.h>
> #include <stdlib.h>
>
> typedef struct {
>         int prog;       //num of program
>         int a;          //A parameter
>         int b;          //B parameter
>         int bank;       //bank number (0 =3D preset, 1 =3D user)
> } pdb;
>
> void affiche(unsigned char a[]) {
>         int i=3D-1;
>
>         printf("The next SySex have been sent trough RawMidi\n");
>
>
>         while (a[i++] !=3D 0xF7) {
>                 printf("%x",a[i]);
>                 printf(" ");
>         }
>         printf("\n");
>         printf("\n");
>
>         return;
> }
>
> void entete(unsigned char mess[]) {
>
>         /* start of SySex */
>         mess[0]=3D0xf0;
>         /* identification Alesis */
>         mess[1]=3D0x00;
>         mess[2]=3D0x00;
>         mess[3]=3D0x0e;
>         /*identification microverb IV*/
>         mess[4]=3D0x12;
>         /* MIDI channel (0x00 =3D omni) */
>         mess[5]=3D0x00;
> }
>
> void sysex_store(unsigned char a[]) {
>
>         // head of SySex
>         entete(a);
>
>         //SySex definition STORE
>         a[6]=3D0x03;
>
>         // EOX
>         a[7]=3D0xF7;
> }
>
> void dump_store(snd_rawmidi_t *handle) {
>         unsigned char sysex[8];
>         ssize_t taille; //### VARIABLE A DECOMMENTER QUAND ON REACTIVE
> L'ENVOIE DU SYSEX ###
>
>         //creation du unsigned char
>         sysex_store(sysex);
>
>         //envoie du unsigned char
>         snd_rawmidi_write(handle,sysex,taille);
>         affiche(sysex);
> }
>
> int main (void) {
>
>         snd_rawmidi_t *handle;
>
>         snd_rawmidi_open(&handle, 0, 0, SND_RAWMIDI_OPEN_DUPLEX);
>

The first argument is input handle, the second is output handle. And the
third
is the device. 0 is eq to NULL, and I don't think you have a device with
that name.
And you migth want to have a output handle since you send data.
And someone  told you. Add error handling checks and then you get to know
on what
calls fails. Or trace in to it on a debugger.

>
>         dump_store(handle);
>
>         snd_rawmidi_close(handle);
>
>         return 0;
> }
>
> /* END OF SOURCE */
>
> Normally, this code create a "store the current program" message and
> send it trough rawmidi... But it don't...
>
> So, where is my error ?
>
> Another small question : how can I force a pause in a program ? Is
> there a function like [delay(10);] who make a pause of 10 miliseconds
> in a execution ? I'll need to make a pause between to sysex later in
> program...
>
> Thanx for help a newbie !!
>
> Charles Fl=E8che
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

--
foo!
