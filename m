From: Charles =?iso-8859-1?Q?Fl=E8che?= <charles.fleche@meletu.univ-valenciennes.fr>
Subject: Getting help about RAWMIDI... I'm getting mad !
Date: Sun, 12 May 2002 18:18:41 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020512181841.A663@pengouin.univ-valenciennes.fr>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from postfix1-2.free.fr (postfix1-2.free.fr [213.228.0.130])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA22686
	for <alsa-devel@alsa-project.org>; Sun, 12 May 2002 18:30:21 +0200
Received: from pengouin (lille-1-a7-62-147-2-49.dial.proxad.net [62.147.2.49])
	by postfix1-2.free.fr (Postfix) with ESMTP id D6853AB57A
	for <alsa-devel@alsa-project.org>; Sun, 12 May 2002 18:30:08 +0200 (CEST)
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

Hello everybody !

First of all, because my main e-mail is down for the moment, this is my 
secondary mails :

	charles.fleche@worldonline.fr
	charles.fleche@free.fr

Thanx for your comprehension !

Secondly, this is my problem : i'm trying to do a dump program to a 
microverb IV to save my patchs. So, I send a sysex to the rack, and 
normally the sysex send me another sysex. So, for the moment, 
everything is working : computer send sysex and the rack send his sysex 
too... BUT... Normally, the sysex sent by the rack is stocked in a 
specific buffer (an unsigned char buffer, in fact). In my case, I find 
in this buffer... the first message, send by the computer to the rack, 
my request buffer !! So I repeat the action (without closing the two 
rawmidi handles), and I found after a few try the sysex sent by the 
rack in my buffer !
	I'm thinking the buffer isn't emptied after each call (but 
remind the computer and the rack send their respective sysex well !). 
So i'm doing a drain of the handle_out after each snd_rawmidi_write, 
but it seem to don't working...
	This is the source code :

/* START OF SOURCE */

#include <alsa/asoundlib.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

typedef struct {
	int prog;	//num of program
	int a;		//A parameter
	int b;		//B parameter
	int bank;	//bank number (0 = preset, 1 = user)
} pdb;

void affiche(unsigned char a[]) {
	int i=-1;
	 
	printf("The next SySex have been sent trough RawMidi\n");
	 
	 
	while (a[i++] != 0xf7) {
		printf("%x",a[i]);
		printf(" ");
	}
	printf("\n");
	printf("\n");
	 
	return;
}

pdb collect() {
	//non definitive function, here just for test without graphical 
interface
	 
	pdb data;
	 
	printf("Program number (0 - 99) : ");
	scanf("%d",&data.prog);
	printf("A parameter (0 - 127) : ");
	scanf("%d",&data.a);
	printf("B parameter (0 - 127) : ");
	scanf("%d",&data.b);
	printf("Bank number (0=preset, 1=user) : ");
	scanf("%d",&data.bank);
	 
	return data;
}

int num_programme() {
	//non definitive function, here just for test without graphical 
interface
	 
	int i;
	 
	printf("Quel est le numero du programme ?\n");
	scanf("%d",&i);
	 
	return i;
}

void entete(unsigned char mess[]) {

	/* start of SySex */
	mess[0]=0xf0;
	/* identification Alesis */
	mess[1]=0x00;
	mess[2]=0x00;
	mess[3]=0x0e;
	/*identification microverb IV*/
	mess[4]=0x12;
	/* MIDI channel (0x00 = omni) */
	mess[5]=0x00;
}
void path(char filename[]) {

	printf("Enter the path to the sysex : ");
	scanf("%s",filename);
}

void read_from_file(char filename[],unsigned char buf[],int size) {
	 
	FILE *fd;

	//open the file
	fd=fopen(filename,"r");
	 
	//read the stream
	fread(buf,size,1,fd);

	//close the file
	fclose(fd);
}

void load_sysex(unsigned char sysex[],int size) {
	char path_to[256];
		 
	path(path_to);
	read_from_file(path_to,sysex,size);
}

void dump_single(snd_rawmidi_t *handle) {
	unsigned char sysex[11];
	 
	//creation du unsigned char
	load_sysex(sysex,12);
	 
	//envoie du unsigned char
	snd_rawmidi_write(handle,sysex,12);
	affiche(sysex);
	 
	return;
}


void dump_store(snd_rawmidi_t *handle) {

	snd_rawmidi_write (handle,"\xf0\x00\x00\x0e\x12\x00\x03\xf7", 
8);
	snd_rawmidi_drain(handle);
}

void dump_all(snd_rawmidi_t *handle) {
	unsigned char sysex[307];
	int i,flag;
	struct timespec *delay;
	 
	delay=(struct timespec *)malloc(sizeof(struct timespec));
		 
	// definie le delai de 10ms
	delay->tv_sec=0;
	delay->tv_nsec=10000000;
	 
	//chargement du sysex
	load_sysex(sysex,308);
	 
	//envoie l'entete du sysex
	for (i=0;i<7;i++)
		snd_rawmidi_write (handle,&sysex[i],1);
	snd_rawmidi_drain(handle);
	 
	flag=0;
	 
	while (i!=308) {
		snd_rawmidi_write (handle,&sysex[i],1);
		i++;
		flag++;
		if (flag==3) {
			nanosleep(delay,NULL);
			flag=0;
			snd_rawmidi_drain(handle);
		}
	}
	 
	affiche(sysex);
}

void sysex_dump_buffer(unsigned char sx[], pdb data) {
	// head of SySex
	entete(sx);
	 
	//opcode DUMP_BUFFER
	sx[6]=0x00;
	 
	//numero de programme
	sx[7]=data.prog;
	 
	//parametre A
	sx[8]=data.a;
	 
	//parametre B
	sx[9]=data.b;
	 
	//choix de la banque
	sx[10]=data.bank;
	 
	//SySex definition
	sx[11]=0xf7;
	 
	return;
}

void dump_buffer(snd_rawmidi_t *handle, pdb data) {
	unsigned char sysex[11];
	 
	//creation du unsigned char
	sysex_dump_buffer(sysex,data);
	 
	//envoie du unsigned char
	snd_rawmidi_write(handle,sysex,12);
	snd_rawmidi_drain(handle);
	 
	affiche(sysex);
	 
	return;
}

void request_buffer(snd_rawmidi_t *handle_out,snd_rawmidi_t *handle_in) 
{
	unsigned char rec[11];
	 
	//envoie du unsigned char
	 
snd_rawmidi_write(handle_out,"\xf0\x00\x00\x0e\x12\x00\x40\xf7",8);
	snd_rawmidi_drain(handle_out);
	 
	//reception du buffer
	snd_rawmidi_read(handle_in,rec,12);
	 
	affiche(rec);
	 
	return;
}

void sysex_request_single(unsigned char sx[],unsigned char num_prog){
	// head of SySex
	entete(sx);
	 
	//opcode REQUEST_SINGLE
	sx[6]=0x42;
	 
	//numero de programme
	sx[7]=num_prog;
	 
	//SySex definition
	sx[8]=0xf7;
	 
	return;
}

void request_single(snd_rawmidi_t *handle_out,snd_rawmidi_t 
*handle_in,unsigned char num_prog) {
	unsigned char sysex[8],rec[11];
	 
	//creation du unsigned char
	sysex_request_single(sysex,num_prog);
	 
	//envoie du unsigned char
	snd_rawmidi_write(handle_out,sysex,9);
	snd_rawmidi_drain(handle_out);
	 
	//reception du buffer
	snd_rawmidi_read(handle_in,rec,12);
	 
	affiche(rec);
	 
	return;
}

void request_all(snd_rawmidi_t *handle_out,snd_rawmidi_t *handle_in) {
	unsigned char rec[307];
	 
	//envoie du request
	 
snd_rawmidi_write(handle_out,"\xf0\x00\x00\x0e\x12\x00\x41\xf7",8);
	snd_rawmidi_drain(handle_out);
	 
	//reception de tous les programmes
	snd_rawmidi_read(handle_in,rec,308);
	 
	affiche(rec);
	 
	return;
}

int main (int argc,char **argv) {
	 
	int choix;
	int err;
	char *device;
	snd_rawmidi_t *handle_in,*handle_out;	//### VARIABLE A 
DECOMMENTER QUAND ON REACTIVE L'ENVOIE DU SYSEX ###

	device=argv[1];	 
	 
	//ouverture des peripherique midi
	//ouverture en lecture
	err = snd_rawmidi_open(&handle_in,NULL,device,0);
	if (err)
		printf("snd_rawmidi_open IN a echoue...\n");
	 
	//ouverture en lecture
	err = snd_rawmidi_open(NULL, &handle_out, device, 0);
	if (err)
		printf("snd_rawmidi_open OUT a echoue...\n");
	 
	printf("Interface logicielle Microverb IV <--> Linux\n");
	printf("Ce programme permet de generer des SySex et de les 
afficher a l'ecran\n");
	printf("\n");
	 
	while (choix != 0) {
		printf("1 - dump edit buffer\n");
		printf("2 - dump all user program\n");
		printf("3 - dump single program\n");
		printf("4 - dump store program\n");
		printf("5 - request edit buffer\n");
		printf("6 - request all user program\n");
		printf("7 - request single program\n");
		printf("0 - bye bye !!\n");
		printf("\n");
		printf("CHOIX : ");
		scanf("%d",&choix);
		printf("\n");
		 
		switch (choix) {
			case 1 : 
dump_buffer(handle_out,collect());break;
			case 2 : dump_all(handle_out);break;
			case 3 : dump_single(handle_out);break;
			case 4 : dump_store(handle_out);break;
			case 5 : 
request_buffer(handle_out,handle_in);break;
			case 6 : 
request_all(handle_out,handle_in);break;
			case 7 : 
request_single(handle_out,handle_in,num_programme());break;
		}
	}
	 
	//fermeture du peripherique midi
	snd_rawmidi_close(handle_in);
	snd_rawmidi_close(handle_out);

	return 0;
}

/* END OF SOURCE */

	Please help me, I'm going insane !

Charles

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
