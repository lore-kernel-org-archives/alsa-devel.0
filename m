From: "James C. Georgas" <jgeorgas@rogers.com>
Subject: snd_ctl_card_info from index
Date: Thu, 05 Jan 2006 15:14:29 -0500
Message-ID: <1136492074.12380.11.camel@Tachyon.home>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

alsa-lib question:

How do I get the snd_ctl_card_info structure, given the card index? I'm
trying to write a program that enumerates all my cards and prints the
hardware information for each one.

Here's my test program as it is now. The commented out describe_card()
function is the one I would like to call, but I can't, because the
function snd_ctl_hw_open() is private.

/// My first alsa program.
/**
 * \date 2005-12-27
 * \author J. C. Georgas
 */


// alsa/asoundlib.h needs this to typedef struct timespec to
snd_htimestamp_t:
#if !(defined _POSIX_C_SOURCE && _POSIX_C_SOURCE >= 199309L)
	#define _POSIX_C_SOURCE 199309L
#endif

#include <stdio.h>
#include <alsa/asoundlib.h>

static int tabcount = 0;
void tab();

int describe_card( const int index );
int describe_controller( const char* name );
int describe_controller_card( snd_ctl_t* ctl );
int describe_controller_element( snd_ctl_t* ctl, int index );

int main( int argc, char* argv[] )
{
	int err = 0;

	// enumerate all the cards and print their imformation:
	int card_number = -1;
	for(;;)
	{
		if ( 0 > ( err = snd_card_next( &card_number )))
		{
			fprintf( stderr, "snd_card_open: %s\n", snd_strerror( err ));
			break;
		}

		if ( -1 == card_number ) break;

		tab(); printf( "Card %d:\n", card_number );

		if ( 0 > ( err = describe_card( card_number )))
		{
			fprintf( stderr, "describe_card: %s\n", snd_strerror( err ));
			continue;
		}
	}

	// I want this stuff in the above loop, but I can't extract ID from
index:
	tab(); printf( "Controller:\n" );

	if ( 0 > ( err = describe_controller( "default" )))
	{
		fprintf( stderr, "describe_controller: %s\n", snd_strerror( err ));
		goto fail_describe_controller;
	}

fail_describe_controller:

	return err;
}

int describe_card( const int index )
{
	int err = 0;
	++tabcount;

	char* name = 0;
	if ( 0 > ( err = snd_card_get_name( index, &name )))
	{
		fprintf( stderr, "snd_card_get_name: %s\n", snd_strerror( err ));
		goto fail_card_get_name;
	}

	tab(); printf( "short name = %s\n", name );

	char* longname = 0;
	if ( 0 > ( err = snd_card_get_longname( index, &longname )))
	{
		fprintf( stderr, "snd_card_get_longname: %s\n", snd_strerror( err ));
		goto fail_card_get_longname;
	}

	tab(); printf( "long name = %s\n", longname );

	free( longname );

fail_card_get_longname:

	free( name );

fail_card_get_name:

	printf( "\n" );
	--tabcount;	
	return err;
}

// I want to get the snd_ctl_card_info, given the index. This is as
close as
// I can get:
#if 0
int describe_card( const int index )
{
	int err = 0;

	snd_ctl_t* ctl;
	if ( 0 > ( err = snd_ctl_hw_open( &ctl, NULL, index, 0 )))
	{
		fprintf( stderr, "snd_ctl_open: %s\n", snd_strerror( err ));
		goto fail_ctl_open;
	}

	if ( 0 > ( err = describe_controller_card( ctl )))
	{
		fprintf( stderr, "describe_controller_card: %s\n",
snd_strerror( err ));
		goto fail_describe_controller_card;
	}

	return err;
}
#endif

int describe_controller( const char* name )
{
	int err = 0;
	++tabcount;

	snd_ctl_t* ctl;
	if ( 0 > ( err = snd_ctl_open( &ctl, name, 0 )))
	{
		fprintf( stderr, "snd_ctl_open: %s\n", snd_strerror( err ));
		goto fail_ctl_open;
	}

	tab(); printf( "Card:\n" );

	if ( 0 > ( err = describe_controller_card( ctl )))
	{
		fprintf( stderr, "describe_controller_card: %s\n",
snd_strerror( err ));
		goto fail_describe_controller_card;
	}

	tab(); printf( "Element:\n" );

	if ( 0 > ( err = describe_controller_element( ctl, 1 )))
	{
		fprintf( stderr, "describe_controller_element: %s\n",
snd_strerror( err));
		goto fail_describe_controller_element;
	}

fail_describe_controller_element:
fail_describe_controller_card:

	snd_ctl_close( ctl );

fail_ctl_open:

	--tabcount;
	return err;
}

int describe_controller_card( snd_ctl_t* ctl )
{
	int err = 0;
	++tabcount;

	snd_ctl_card_info_t* info;
	if ( 0 > ( err = snd_ctl_card_info_malloc( &info )))
	{
		fprintf( stderr, "snd_ctl_card_info_malloc: %s\n",
snd_strerror( err ));
		goto fail_ctl_card_info_malloc;
	}

	if ( 0 > ( err = snd_ctl_card_info( ctl, info )))
	{
		fprintf( stderr, "snd_ctl_card_info: %s\n", snd_strerror( err ));
		goto fail_ctl_card_info;
	}

	tab();printf( "index      = %d\n", snd_ctl_card_info_get_card( info ));
	tab();printf( "ID         = %s\n", snd_ctl_card_info_get_id( info ));
	tab();printf( "short name = %s\n", snd_ctl_card_info_get_name( info ));
	tab();printf( "long name  = %s\n",
snd_ctl_card_info_get_longname( info ));
	tab();printf( "components = %s\n",
snd_ctl_card_info_get_components( info ));
	tab();printf( "mixer name = %s\n",
snd_ctl_card_info_get_mixername( info));
	tab();printf( "driver     = %s\n",
snd_ctl_card_info_get_driver( info ));

fail_ctl_card_info:

	snd_ctl_card_info_free( info );

fail_ctl_card_info_malloc:

	printf( "\n" );
	--tabcount;
	return err;
}

int describe_controller_element( snd_ctl_t* ctl, int index )
{
	int err = 0;
	++tabcount;

	snd_ctl_elem_info_t* info;
	if ( 0 > ( err = snd_ctl_elem_info_malloc( &info )))
	{
		fprintf( stderr, "snd_ctl_elem_info_malloc: %s\n",
snd_strerror( err ));
		goto fail_ctl_elem_info_malloc;
	}

	snd_ctl_elem_info_set_numid( info, index );
	if ( 0 > ( err = snd_ctl_elem_info( ctl, info )))
	{
		fprintf( stderr, "snd_ctl_elem_info: %s\n", snd_strerror( err ));
		goto fail_ctl_elem_info;
	}

	tab(); printf( "ID         = %d\n",
snd_ctl_elem_info_get_numid( info ));
	tab(); printf( "name       = %s\n",
snd_ctl_elem_info_get_name( info ));

	int type = snd_ctl_elem_info_get_type( info );
	char* typename;
	switch ( type )
	{
	case SND_CTL_ELEM_TYPE_NONE: typename = "NONE"; break;
	case SND_CTL_ELEM_TYPE_BOOLEAN: typename = "BOOLEAN"; break;
	case SND_CTL_ELEM_TYPE_INTEGER: typename = "INTEGER"; break;
	case SND_CTL_ELEM_TYPE_ENUMERATED: typename = "ENUMERATED"; break;
	case SND_CTL_ELEM_TYPE_BYTES: typename = "BYTES"; break;
	case SND_CTL_ELEM_TYPE_IEC958: typename = "IEC958"; break;
	case SND_CTL_ELEM_TYPE_INTEGER64: typename = "INTEGER64"; break;
	}
	tab(); printf( "type       = %s\n", typename );

	tab(); printf( "values     = %d\n",
snd_ctl_elem_info_get_count( info ));
	tab(); printf( "dimensions = %d\n",
snd_ctl_elem_info_get_dimensions(info));

fail_ctl_elem_info:

	snd_ctl_elem_info_free( info );

fail_ctl_elem_info_malloc:

	printf( "\n" );
	--tabcount;
	return err;
}

void tab()
{
	for ( int i = 0; tabcount > i; ++i )
		printf( "\t" );
}


-- 
James C. Georgas <jgeorgas@rogers.com>



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
